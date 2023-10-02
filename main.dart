import 'Calc/Executing/runner.dart';

void main() {
  Runner runner = Runner();

  // print(runner.run("a = [1, 1 + 1, 3]"));
  // print(runner.run("a"));

  // print("");

  // print(runner.run("a + 2"));
  // print(runner.run("a * 2"));
  // print(runner.run("a - 2"));
  // print(runner.run("a / 2"));

  // print("");

  // print(runner.run("2 + a"));
  // print(runner.run("2 * a"));
  // print(runner.run("2 - a"));
  // print(runner.run("2 / a"));

  print(runner.run("mat = [[0,1], [2, 3]]"));
  print(runner.run("mat * 2"));
}
