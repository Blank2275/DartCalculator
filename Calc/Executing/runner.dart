import '../Lexing/lexer.dart';
import '../Parsing/declaration.dart';
import '../Parsing/parser.dart';
import '../Parsing/scriptParser.dart';
import 'executer.dart';
import 'value.dart';

class Runner {
  Executer executer = Executer();

  Value run(String equation) {
    Parser parser = Parser(lex(equation));
    Decl ast = parser.parseDeclaration();
    return executer.executeDeclaration(ast);
  }

  void runScript(String script) {
    ScriptParser parser = ScriptParser(lex(script));
    List<Decl> declarations = parser.parseAll();
    executer.runProgram(declarations);
  }
}
