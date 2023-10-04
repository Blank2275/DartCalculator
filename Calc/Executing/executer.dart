import '../Lexing/token.dart';
import '../Parsing/Parameter.dart';
import '../Parsing/block.dart';
import '../Parsing/declaration.dart';
import '../Parsing/expression.dart';
import '../Parsing/statement.dart';
import 'context.dart';
import 'func.dart';
import 'value.dart';

class Executer {
  StandardContext context = StandardContext();
  bool isRunning = true;

  void runtimeError(String message) {
    print("Runtime Error: $message");
    isRunning = false;
  }

  void typeError(String message) {
    print("Type Error: $message");
    isRunning = false;
  }

  void executeBlock(Block block) {
    int i = 0;
    while (i < block.statements.length &&
        context.returnResult is EmptyValue &&
        isRunning) {
      handleStatement(block.statements[i]);

      i += 1;
    }
  }

  void runProgram(List<Decl> program) {
    isRunning = true;
    for (Decl decl in program) {
      executeDeclaration(decl);
      if (!isRunning) break;
    }
  }

  Value executeDeclaration(Decl tree) {
    if (tree is StmtDecl) {
      Stmt stmt = tree.stmt;

      return handleStatement(stmt);
    } else if (tree is FuncDecl) {
      String name = tree.name.value!;
      List<Parameter> parameters = tree.parameters;
      Expr body = tree.body;

      ExprFunc func = ExprFunc(parameters, body);

      context.setFunction(name, func);
    } else if (tree is ScriptFuncDecl) {
      String name = tree.name.value!;
      List<Parameter> parameters = tree.parameters;
      Block body = tree.body;

      ScriptFunc func = ScriptFunc(parameters, body);

      context.setFunction(name, func);
    }

    return NullValue();
  }

  Value handleStatement(Stmt stmt) {
    if (stmt is ExprStmt) {
      Expr expr = stmt.expr;

      return handleExpression(expr);
    } else if (stmt is AssignmentStmt) {
      String name = stmt.name.value!;
      Expr expr = stmt.value;
      Value value = handleExpression(expr);

      context.setVariable(name, value);
      return value;
    } else if (stmt is IfElseStmt) {
      Expr condition = stmt.condition;
      Stmt onTrue = stmt.onTrue;
      Stmt onFalse = stmt.onFalse;

      Value conditionValue = handleExpression(condition);

      if (!(conditionValue is BooleanValue)) return NullValue();

      if (conditionValue.value) {
        handleStatement(onTrue);
      } else {
        handleStatement(onFalse);
      }
    } else if (stmt is ForStmt) {
      Value array = handleExpression(stmt.value);
      String iteratorName = stmt.iterator.value.value!;

      if (!(array is ArrayValue)) {
        return NullValue();
      }

      for (Value element in array.value) {
        context.addBlockLevel();
        context.setVariable(iteratorName, element);

        executeBlock(stmt.body);

        context.popBlockLevel();
      }
    } else if (stmt is WhileStmt) {
      Expr condition = stmt.condition;

      while ((handleExpression(condition) as BooleanValue).value) {
        context.addBlockLevel();
        executeBlock(stmt.body);
        context.popBlockLevel();
      }
    } else if (stmt is IfElifElseStmt) {
      for (int i = 0; i < stmt.conditions.length; i++) {
        Value conditionValue = handleExpression(stmt.conditions[i]);

        if (!(conditionValue is BooleanValue)) return NullValue();

        if (conditionValue.value) {
          context.addBlockLevel();
          executeBlock(stmt.blocks[i]);
          context.popBlockLevel();

          return NullValue();
        }
      }

      if (stmt.conditions.length < stmt.blocks.length) {
        context.addBlockLevel();
        executeBlock(stmt.blocks[stmt.blocks.length - 1]);
        context.popBlockLevel();

        return NullValue();
      }
    } else if (stmt is PrintStmt) {
      Expr value = stmt.value;
      Value val = handleExpression(value);

      if (!isRunning) return NullValue();

      print(val); // keep
    } else if (stmt is ReturnStmt) {
      Expr value = stmt.value;
      context.returnResult = handleExpression(value);
    }

    return NullValue();
  }

  Value handleExpression(Expr expr) {
    if (expr is BinaryExpr) {
      return handleBinary(expr);
    } else if (expr is TernaryExpr) {
      Expr condition = expr.condition;
      Expr onTrue = expr.onTrue;
      Expr onFalse = expr.onFalse;

      Value conditionValue = handleExpression(condition);

      if (!(conditionValue is BooleanValue)) return NullValue();

      if (conditionValue.value) {
        return handleExpression(onTrue);
      } else {
        return handleExpression(onFalse);
      }
    } else if (expr is UnaryExpr) {
      return handleUnary(expr);
    } else if (expr is GroupingExpr) {
      return handleExpression(expr.child);
    } else if (expr is NumberExpr) {
      return NumberValue(expr.getDoubleValue());
    } else if (expr is BooleanExpr) {
      return BooleanValue(expr.value.value == "true" ? true : false);
    } else if (expr is IdentifierExpr) {
      String name = expr.value.value!;

      return context.getVariable(name);
    } else if (expr is ReferenceExpr) {
      String name = expr.value.value!;

      return context.getReferencedVariable(name);
    } else if (expr is ArrayExpr) {
      List<Expr> elements = expr.value;
      List<Value> values = [];

      for (Expr element in elements) {
        Value val = handleExpression(element);
        if (val is ErrorValue) {
          typeError(val.message);
        }
        values.add(val);
      }

      return ArrayValue(values);
    } else if (expr is FuncCallExpr) {
      String name = expr.name.value!;
      Func func = context.getFunction(name);

      List<Expr> argumentExprs = expr.arguments;

      List<Value> arguments = [];

      for (Expr element in argumentExprs) {
        arguments.add(handleExpression(element));
      }

      Value? val = null;

      if (func is ExprFunc) {
        context.addStackFrame();
        List<Parameter> parameters = func.parameters;

        for (int i = 0; i < parameters.length; i++) {
          context.setVariable(parameters[i].name, arguments[i]);
        }

        val = handleExpression(func.expr);

        context.popStackFrame();
      } else if (func is ScriptFunc) {
        context.addStackFrame();
        List<Parameter> parameters = func.parameters;

        for (int i = 0; i < parameters.length; i++) {
          context.setVariable(parameters[i].name, arguments[i]);
        }

        Block body = func.body;

        executeBlock(body);

        val = context.returnResult;
        context.returnResult = EmptyValue();

        if (val is EmptyValue) return NullValue();

        context.popStackFrame();
      } else {
        val = func.evaluate(arguments);
      }

      if (val is ErrorValue) {
        runtimeError(val.message);
      } else if (val is ArrayValue) {
        for (Value element in val.value) {
          if (element is ErrorValue) runtimeError(element.message);
        }
      }

      return val;
    }

    return NullValue();
  }

  Value handleUnary(UnaryExpr expr) {
    if (expr.op.type == TokenType.SUB) {
      Value child = handleExpression(expr.child);

      return child.mul(NumberValue(-1));
    }

    return NullValue();
  }

  Value handleBinary(BinaryExpr expr) {
    Value? val = null;

    if (expr.op.type == TokenType.ADD) {
      Value left = handleExpression(expr.left);
      Value right = handleExpression(expr.right);

      val = left.add(right);
    }
    if (expr.op.type == TokenType.SUB) {
      Value left = handleExpression(expr.left);
      Value right = handleExpression(expr.right);

      val = left.sub(right);
    }
    if (expr.op.type == TokenType.MUL) {
      Value left = handleExpression(expr.left);
      Value right = handleExpression(expr.right);

      val = left.mul(right);
    }
    if (expr.op.type == TokenType.DIV) {
      Value left = handleExpression(expr.left);
      Value right = handleExpression(expr.right);

      val = left.div(right);
    }

    if (expr.op.type == TokenType.LT) {
      Value left = handleExpression(expr.left);
      Value right = handleExpression(expr.right);

      val = left.lt(right);
    }

    if (expr.op.type == TokenType.GT) {
      Value left = handleExpression(expr.left);
      Value right = handleExpression(expr.right);

      val = left.gt(right);
    }

    if (expr.op.type == TokenType.LE) {
      Value left = handleExpression(expr.left);
      Value right = handleExpression(expr.right);

      val = left.le(right);
    }

    if (expr.op.type == TokenType.GE) {
      Value left = handleExpression(expr.left);
      Value right = handleExpression(expr.right);

      val = left.ge(right);
    }

    if (expr.op.type == TokenType.EQ) {
      Value left = handleExpression(expr.left);
      Value right = handleExpression(expr.right);

      val = left.eq(right);
    }

    if (expr.op.type == TokenType.NE) {
      Value left = handleExpression(expr.left);
      Value right = handleExpression(expr.right);

      val = left.ne(right);
    }

    if (expr.op.type == TokenType.AND) {
      Value left = handleExpression(expr.left);
      Value right = handleExpression(expr.right);

      val = left.and(right);
    }

    if (expr.op.type == TokenType.OR) {
      Value left = handleExpression(expr.left);
      Value right = handleExpression(expr.right);

      val = left.or(right);
    }

    if (val is ErrorValue) {
      typeError(val.message);
    } else if (val is ArrayValue) {
      for (Value element in val.value) {
        if (element is ErrorValue) typeError(element.message);
      }
    }

    if (val != null) return val;

    return NullValue();
  }
}
