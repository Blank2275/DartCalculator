import '../Lexing/token.dart';
import '../Parsing/declaration.dart';
import '../Parsing/expression.dart';
import '../Parsing/statement.dart';
import 'context.dart';
import 'value.dart';

class Executer {
  Context context = Context();

  Value executeDeclaration(Decl tree) {
    if (tree is StmtDecl) {
      Stmt stmt = tree.stmt;

      return handleStatement(stmt);
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

    return NullValue();
  }
}
