import '../Lexing/token.dart';
import 'block.dart';
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

class IfElifElseStmt extends Stmt {
  List<Expr> conditions;
  List<Block> blocks;

  IfElifElseStmt(this.conditions, this.blocks);

  String pretty(int level) {
    String prefix = "    " * level;

    String conditionsStr = "";

    for (int i = 0; i < conditions.length; i++) {
      if (i == 0) {
        conditionsStr += "${prefix}if(\n${conditions[i]}\n)\n";
        conditionsStr += this.blocks[i].pretty(level + 1);
        conditionsStr += "${prefix}end\n";
      } else {
        conditionsStr += "${prefix}elif(\n${conditions[i]}\n)\n";
        conditionsStr += this.blocks[i].pretty(level + 1);
        conditionsStr += "${prefix}end\n";
      }
    }

    if (conditions.length < blocks.length) {
      conditionsStr += "${prefix}else\n";
      conditionsStr += this.blocks[this.blocks.length - 1].pretty(level + 1);
      conditionsStr += "\n${prefix}end\n";
    }

    return conditionsStr;
  }

  @override
  String toString() {
    return pretty(0);
  }
}

class PrintStmt extends Stmt {
  Expr value;

  PrintStmt(this.value);

  String pretty(int level) {
    String prefix = "    " * level;

    return """print\n
$value
""";
  }

  @override
  String toString() {
    return pretty(0);
  }
}

class ForStmt extends Stmt {
  Expr value;
  IdentifierExpr iterator;
  Block body;

  ForStmt(this.iterator, this.value, this.body);

  String pretty(int level) {
    return """for $iterator in $value do
$body
end""";
  }

  @override
  String toString() {
    return pretty(0);
  }
}

class WhileStmt extends Stmt {
  Expr condition;
  Block body;

  WhileStmt(this.condition, this.body);

  String pretty(int level) {
    return """while $condition do
$body
end""";
  }

  @override
  String toString() {
    return pretty(0);
  }
}

class IfElseStmt extends Stmt {
  Expr condition;
  Stmt onTrue;
  Stmt onFalse;

  IfElseStmt(this.condition, this.onTrue, this.onFalse);

  String pretty(int level) {
    String prefix = "    " * level;

    return """${prefix}If (${condition.pretty(0)}){
${onTrue.pretty(level + 1)}
${prefix}} Else {
${onFalse.pretty(level + 1)}
${prefix}}""";
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
