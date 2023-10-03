import 'Calc/Executing/runner.dart';
import 'Calc/Lexing/lexer.dart';
import 'Calc/Parsing/parser.dart';
import 'Calc/Parsing/scriptParser.dart';

void main() {
  Runner runner = Runner();

  String testScript = """
arr = [0, 1, 2, 3, 4 + 1]

for (i in arr) do
  for (j in arr) do
    if (i > j) do
      print j / i
    end
  end
end
print i
""";

  // print(ScriptParser(lex(testScript)).parseAll());
  runner.runScript(testScript);
}
