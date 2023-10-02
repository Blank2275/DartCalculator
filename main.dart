import 'Calc/Executing/runner.dart';

void main() {
  Runner runner = Runner();

  print(runner.run("fun f(number x, y) = 5 * x + y"));
  print(runner.run("f(2, 3)"));
  print(runner.run("f(1, -2)"));

  print(runner.run("sin(3.141592)"));
}
