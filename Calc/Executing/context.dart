import 'value.dart';

class Context {
  Map<String, Value> variables = {};

  void setVariable(String name, Value value) {
    variables[name] = value;
  }

  Value getVariable(String name) {
    Value? val = variables[name];

    if (val != null) return val;
    return NullValue();
  }
}
