import 'Calc/Executing/runner.dart';

void main() {
  Runner runner = Runner();

  print(runner.run("2 + 3 * 5"));
  print(runner.run("a = 2 + 3 * 5"));
  print(runner.run("a"));
  print(runner.run("b = a + 2"));
  print(runner.run("a + b"));
}
