import '../Lexing/token.dart';
import 'Type.dart';

class Parameter {
  ValueType type;
  String name;

  Parameter(this.type, this.name);
}
