import 'Calc/Lexing/lexer.dart';
import 'Calc/Lexing/token.dart';
import 'Calc/Parsing/parser.dart';

void main() {
  String testExpr = "[0, 1, 5 * 7, sin(2)]";
  // String testExpr = "- x";

  Parser parser = Parser(lex(testExpr));

  print(parser.parseExpression());
}
