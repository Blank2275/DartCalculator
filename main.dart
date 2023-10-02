import 'Calc/Executing/executer.dart';
import 'Calc/Lexing/lexer.dart';
import 'Calc/Lexing/token.dart';
import 'Calc/Parsing/declaration.dart';
import 'Calc/Parsing/parser.dart';

void main() {
  String testStr = "2 * (3 + 4 / 3)";

  Parser parser = Parser(lex(testStr));
  Decl ast = parser.parseDeclaration();

  Executer executer = Executer();
  print(executer.executeDeclaration(ast));
}
