import '../Lexing/token.dart';
import 'expression.dart';

class Stmt {}

class AssignmentStmt {
  Token name;
  Expr value;

  AssignmentStmt(this.name, this.value);

  String pretty(int level) {
    String prefix = "    " * level;

    return """${prefix}Assigment {
${prefix + "    "}name {
${prefix + "    " * 2}${name.value}
${prefix + "    "}}
${prefix + "    "}name {
${value.pretty(level + 2)}
${prefix + "    "}}
${prefix}""";
  }

  @override
  String toString() {
    return pretty(0);
  }
}

class ExprStmt {
  Expr expr;

  ExprStmt(this.expr);

  String pretty(int level) {
    return this.expr.pretty(level);
  }

  @override
  String toString() {
    return pretty(0);
  }
}
