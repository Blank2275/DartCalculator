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
  // String testDecl = "(-x + 3) / 2";

  // String testIf = "if (5 > a) a = a - 5 else a = a + 5";
  // String testIf = "1 + if (a + b < c) a + b else c";
  // String testIf = "if (2 > 1) 2";

  // print(lex(testIf));

  // String testTernary = "5 > a ? 5 : a";
  // String testTernary = "(a > 1 ? 1 : 2) > a ? 5 : a";
  // String testTernary = "5 > a ? 5 : (7 > a ? a : 7)";
  // String testTernary = "a == 1 ? a : 1";
  // String testTernary = "5 + (3 - 7)";

  // Parser parser = Parser(lex(testTernary));

  print(parser.parseDeclaration());
}
