import 'Calc/Executing/runner.dart';
import 'Calc/Lexing/lexer.dart';
import 'Calc/Parsing/parser.dart';
import 'Calc/Parsing/scriptParser.dart';

void main() {
  Runner runner = Runner();

  String testScript = """
a = 0
if (1 + 1 != 2) do
  a = 2
end
elif (1 + 1 == 3) do
  a = 3
end
else
  a = -1
end
print a * 2
""";

  runner.runScript(testScript);
}
