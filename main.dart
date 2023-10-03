import 'Calc/Executing/runner.dart';
import 'Calc/Lexing/lexer.dart';
import 'Calc/Parsing/parser.dart';
import 'Calc/Parsing/scriptParser.dart';

void main() {
  Runner runner = Runner();

  String testScript = """
fun range(start, stop, step) do
  arr = []
  if (start == stop) do
    return []
  end

  if (start < stop) do
    if (step <= 0) do
      return []
    end
    while (start < stop) do
      add(arr, start)
      start = start + step
    end
  end 
  else
    if (step >= 0) do
      return []
    end
    while (start > stop) do
      add(arr, start)
      start = start + step
    end
  end

  return arr
end

fun factorial(n) do
  if (n <= 2) do
    return n 
  end
  
  return n * factorial(n - 1)
end

for (i in range(0, 10, 1)) do
  print factorial(i)
end

for (i in range(0, 1000000, 1)) do
  print (1 / sin(i * i))
end
""";

  // print(ScriptParser(lex(testScript)).parseAll());
  runner.runScript(testScript);
}
