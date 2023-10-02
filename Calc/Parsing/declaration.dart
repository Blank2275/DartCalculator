import '../Lexing/token.dart';
import 'Parameter.dart';
import 'expression.dart';
import 'statement.dart';

class Decl {
  String pretty(int level) {
    String prefix = "    " * level;

    return "Decl";
  }

  @override
  String toString() {
    return pretty(0);
  }
}

class StmtDecl extends Decl {
  Stmt stmt;

  StmtDecl(this.stmt);

  String pretty(int level) {
    return stmt.pretty(level);
  }

  @override
  String toString() {
    return pretty(0);
  }
}

class FuncDecl extends Decl {
  Token name;
  List<Parameter> parameters;
  Expr body;

  FuncDecl(this.name, this.parameters, this.body);

  String pretty(int level) {
    String prefix = "    " * level;

    String parametersString = "${"    " * (level + 2)}[\n";
    for (Parameter parameter in parameters) {
      parametersString +=
          "${"    " * (level + 3)}${parameter.type.name} ${parameter.name},\n";
    }
    parametersString += "${"    " * (level + 2)}]";

    return """${prefix}Function Declaration {
${prefix + "    "}name (${name.value})
${prefix + "    "}parameters {
${parametersString}
${prefix + "    "}}
${prefix + "    "}body {
${body.pretty(level + 2)}
${prefix + "    "}}
${prefix}}""";
  }
}
