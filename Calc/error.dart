import 'Lexing/token.dart';

void parseError(String message) {
  throw "Parse Error: $message";
}

void runtimeError(String message) {
  throw "Runtime Error: $message";
}
