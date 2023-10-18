import 'Lexing/token.dart';

void parseError(String message) {
  print("Parse Error: $message");
}

void runtimeError(String message) {
  throw "Runtime Error: $message";
}
