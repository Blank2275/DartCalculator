import '../Lexing/token.dart';
import 'expression.dart';

class Stmt {
  String pretty(int level) {
    String prefix = "    " * level;

    return "Stmt";
  }

  @override
  String toString() {
    return pretty(0);
  }
}

class AssignmentStmt extends Stmt {
  Token name;
  Expr value;

  AssignmentStmt(this.name, this.value);

  String pretty(int level) {
    String prefix = "    " * level;

    return """${prefix}Assigment {
${prefix + "    "}name {
${prefix + "    " * 2}${name.value}
${prefix + "    "}}
${prefix + "    "}value {
${value.pretty(level + 2)}
${prefix + "    "}}
${prefix}""";
  }

  @override
  String toString() {
    return pretty(0);
  }
}

class ExprStmt extends Stmt {
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

class NullStmt extends Stmt {
  // should never come up, just a filler for default case in parsing

  String pretty(int level) {
    String prefix = "    " * level;
    return "${prefix}NullStmt";
  }

  @override
  String toString() {
    return pretty(0);
  }
}
