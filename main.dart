import 'Calc/Executing/runner.dart';
import 'Calc/Lexing/lexer.dart';
import 'Calc/Parsing/parser.dart';
import 'Calc/Parsing/scriptParser.dart';

void main() {
  Runner runner = Runner();

  String testScript = """
a = [0, 1, 2]

a = a.add(3)

print a.set(2, 1)
print a
""";

  print(ScriptParser(lex(testScript)).parseAll());
  // runner.runScript(testScript);
}
