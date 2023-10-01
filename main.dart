import 'lexer.dart';
import 'parser.dart';

void main() {
  String testExpr = "a - (3 * -x + sin(5) / pow(x, 2))";
  // String testExpr = "- x";

  print(lex(testExpr));
  Parser parser = Parser(lex(testExpr));

  print(parser.parseExpression());
}
