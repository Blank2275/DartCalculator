import '../Lexing/token.dart';
import '../Parsing/declaration.dart';
import '../Parsing/expression.dart';
import '../Parsing/statement.dart';
import 'value.dart';

class Executer {
  Value executeDeclaration(Decl tree) {
    if (tree is StmtDecl) {
      Stmt stmt = tree.stmt;
      if (stmt is ExprStmt) {
        Expr expr = stmt.expr;

        return handleExpression(expr);
      }
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
    }

    return NullValue();
  }

  Value handleBinary(BinaryExpr expr) {
    print(expr);
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
