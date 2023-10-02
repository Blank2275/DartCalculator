import 'Calc/Executing/runner.dart';
import 'Calc/Lexing/lexer.dart';
import 'Calc/Parsing/parser.dart';
import 'Calc/Parsing/scriptParser.dart';

void main() {
  Runner runner = Runner();

  String testScript = """
if (true) do
  x = 5
  print x
end
print x
""";

  runner.runScript(testScript);
}
