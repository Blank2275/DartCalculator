import 'Calc/Lexing/lexer.dart';
import 'Calc/Lexing/token.dart';
import 'Calc/Parsing/parser.dart';

void main() {
  // String testStmt = "a = b + 5.5";
  // String testStmt = "5 * cos(5)";
  // String testStmt = "ab2=-(x + 5)";
  // String testStmt = "(-x + 5)";

  // String testDecl = "fun f() = 1";
  // String testDecl = "fun gh(x) = x + 1";
  String testDecl = "(-x + 3) / 2";

  Parser parser = Parser(lex(testDecl));

  print(parser.parseDeclaration());
}
