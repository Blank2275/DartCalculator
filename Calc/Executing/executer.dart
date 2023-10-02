import '../Lexing/token.dart';
import '../Parsing/Parameter.dart';
import '../Parsing/declaration.dart';
import '../Parsing/expression.dart';
import '../Parsing/statement.dart';
import 'context.dart';
import 'func.dart';
import 'value.dart';

class Executer {
  StandardContext context = StandardContext();

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
    }

    return NullValue();
  }

  Value handleExpression(Expr expr) {
    if (expr is BinaryExpr) {
      return handleBinary(expr);
    } else if (expr is UnaryExpr) {
      return handleUnary(expr);
    } else if (expr is GroupingExpr) {
      return handleExpression(expr.child);
    } else if (expr is NumberExpr) {
      return NumberValue(expr.getDoubleValue());
    } else if (expr is IdentifierExpr) {
      String name = expr.value.value!;

      return context.getVariable(name);
    } else if (expr is ArrayExpr) {
      List<Expr> elements = expr.value;
      List<Value> values = [];

      for (Expr element in elements) {
        values.add(handleExpression(element));
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

      if (func is ExprFunc) {
        context.addStackFrame();
        print(context.stack.length);
        List<Parameter> parameters = func.parameters;

        for (int i = 0; i < parameters.length; i++) {
          context.setVariable(parameters[i].name, arguments[i]);
        }

        Value val = handleExpression(func.expr);

        context.popStackFrame();
        print(context.stack.length);

        return val;
      } else {
        return func.evaluate(arguments);
      }
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
    if (expr.op.type == TokenType.ADD) {
      Value left = handleExpression(expr.left);
      Value right = handleExpression(expr.right);

      return left.add(right);
    }
    if (expr.op.type == TokenType.SUB) {
      Value left = handleExpression(expr.left);
      Value right = handleExpression(expr.right);

      return left.sub(right);
    }
    if (expr.op.type == TokenType.MUL) {
      Value left = handleExpression(expr.left);
      Value right = handleExpression(expr.right);

      return left.mul(right);
    }
    if (expr.op.type == TokenType.DIV) {
      Value left = handleExpression(expr.left);
      Value right = handleExpression(expr.right);

      return left.div(right);
    }

    if (expr.op.type == TokenType.LT) {
      Value left = handleExpression(expr.left);
      Value right = handleExpression(expr.right);

      return left.lt(right);
    }

    if (expr.op.type == TokenType.GT) {
      Value left = handleExpression(expr.left);
      Value right = handleExpression(expr.right);

      return left.gt(right);
    }

    if (expr.op.type == TokenType.LE) {
      Value left = handleExpression(expr.left);
      Value right = handleExpression(expr.right);

      return left.le(right);
    }

    if (expr.op.type == TokenType.GE) {
      Value left = handleExpression(expr.left);
      Value right = handleExpression(expr.right);

      return left.ge(right);
    }

    if (expr.op.type == TokenType.AND) {
      Value left = handleExpression(expr.left);
      Value right = handleExpression(expr.right);

      return left.and(right);
    }

    if (expr.op.type == TokenType.OR) {
      Value left = handleExpression(expr.left);
      Value right = handleExpression(expr.right);

      return left.or(right);
    }

    return NullValue();
  }
}
