import '../Lexing/token.dart';

class Expr {
  String pretty(int level) {
    return "Expr";
  }

  @override
  String toString() {
    return pretty(0);
  }
}

class BinaryExpr extends Expr {
  Expr left;
  Expr right;
  Token op;

  BinaryExpr(this.left, this.right, this.op);

  String pretty(int level) {
    String prefix = "    " * level;
    return """${prefix}Binary {
${prefix + "    "}left {
${left.pretty(level + 2)}
${prefix + "    "}}
${prefix + "    "}op (${op.type})
${prefix + "    "}right {
${right.pretty(level + 2)}
${prefix + "    "}}
${prefix}}""";
  }

  @override
  String toString() {
    return pretty(0);
  }
}

class UnaryExpr extends Expr {
  Expr child;
  Token op;

  UnaryExpr(this.child, this.op);

  String pretty(int level) {
    String prefix = "    " * level;
    return """${prefix}Unary (${op.type}) {
${prefix + "    "}child {
${child.pretty(level + 2)}
${prefix + "    "}}
${prefix}}""";
  }

  @override
  String toString() {
    return pretty(0);
  }
}

class TernaryExpr extends Expr {
  Expr condition;
  Expr onTrue;
  Expr onFalse;

  TernaryExpr(this.condition, this.onTrue, this.onFalse);

  String pretty(int level) {
    String prefix = "    " * level;
    return """${prefix}Ternary {
${prefix + "    "}condition {
${condition.pretty(level + 2)}
${prefix + "    "}}
${prefix + "    "}true {
${onTrue.pretty(level + 2)}
${prefix + "    "}}
${prefix + "    "}false {
${onFalse.pretty(level + 2)}
${prefix + "    "}}
${prefix}}""";
  }

  @override
  String toString() {
    return pretty(0);
  }
}

class GroupingExpr extends Expr {
  Expr child;

  GroupingExpr(this.child);

  String pretty(int level) {
    String prefix = "    " * level;
    return """${prefix}Grouping {
${child.pretty(level + 1)}
${prefix}}""";
  }

  @override
  String toString() {
    return pretty(0);
  }
}

class FuncCallExpr extends Expr {
  Token name;
  List<Expr> arguments;

  FuncCallExpr(this.name, this.arguments);

  String pretty(int level) {
    String prefix = "    " * level;

    String argumentsString = "${"    " * (level + 2)}[\n";
    for (Expr argument in arguments) {
      argumentsString += argument.pretty(level + 2) + ",\n";
    }
    argumentsString += "${"    " * (level + 2)}]";

    return """${prefix}FunctionCall {
${prefix + "    "}name(${name.value})
${prefix + "    "}arguments {
${argumentsString}
${prefix + "    "}}
${prefix}}""";
  }

  @override
  String toString() {
    return pretty(0);
  }
}

class NumberExpr extends Expr {
  Token value;

  NumberExpr(this.value);

  double getDoubleValue() {
    return double.parse(value.value!);
  }

  String pretty(int level) {
    String prefix = "    " * level;
    return "${prefix}Number (${this.value.value})";
  }

  @override
  String toString() {
    return pretty(0);
  }
}

class BooleanExpr extends Expr {
  Token value;

  BooleanExpr(this.value);

  bool getBooleanValue() {
    return value.value! == "true";
  }

  String pretty(int level) {
    String prefix = "    " * level;
    return "${prefix}Boolean (${this.value.value})";
  }

  @override
  String toString() {
    return pretty(0);
  }
}

class ReferenceExpr extends Expr {
  Token value;

  ReferenceExpr(this.value);

  String pretty(int level) {
    String prefix = "    " * level;
    return "${prefix}Reference (${this.value.value})";
  }

  @override
  String toString() {
    return pretty(0);
  }
}

class IdentifierExpr extends Expr {
  Token value;

  IdentifierExpr(this.value);

  String pretty(int level) {
    String prefix = "    " * level;
    return "${prefix}Identifier (${this.value.value})";
  }

  @override
  String toString() {
    return pretty(0);
  }
}

class ArrayExpr extends Expr {
  List<Expr> value;

  ArrayExpr(this.value);

  String pretty(int level) {
    String prefix = "    " * level;

    String elementsString = "${"    " * (level + 2)}[\n";
    for (Expr element in value) {
      elementsString += element.pretty(level + 2) + ",\n";
    }
    elementsString += "${"    " * (level + 2)}]";

    return """${prefix}Array {
${prefix + "    "}elements {
${elementsString}
${prefix + "    "}}
${prefix}}""";
  }

  @override
  String toString() {
    return pretty(0);
  }
}

class NullExpr extends Expr {
  // should never come up, just a filler for default case in parsing

  String pretty(int level) {
    String prefix = "    " * level;
    return "${prefix}NullExpr";
  }

  @override
  String toString() {
    return pretty(0);
  }
}
