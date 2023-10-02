import 'statement.dart';

class Block {
  List<Stmt> statements;

  Block(this.statements);

  String pretty(int level) {
    String prefix = "    " * level;

    String res = "${prefix}{";
    for (Stmt stmt in statements) {
      res += stmt.pretty(level + 1);
    }
    res += "${prefix}}";

    return res;
  }
}
