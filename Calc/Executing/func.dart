import 'dart:math';

import '../Parsing/Parameter.dart';
import '../Parsing/Type.dart';
import '../Parsing/expression.dart';
import 'value.dart';

class Func {
  List<Parameter> parameters;

  Func(this.parameters);

  Value evaluate(List<Value> arguments) {
    if (!validArguments(arguments, parameters)) {
      return NullValue();
    }

    return _evaluate(arguments);
  }

  Value _evaluate(List<Value> arguments) {
    return NullValue();
  }

  bool validArguments(List<Value> arguments, List<Parameter> parameters) {
    if (arguments.length != parameters.length) return false;

    for (int i = 0; i < arguments.length; i++) {
      String typeName = parameters[i].type.name;

      if (arguments[i] is NumberValue && typeName != "number") return false;
      if (arguments[i] is ArrayValue && typeName != "array") return false;
      // if (arguments[i] is BooleanValue && typeName != "boolean") return false;
    }

    return true;
  }
}

class NullFunc extends Func {
  NullFunc() : super([]);
}

class ExprFunc extends Func {
  Expr expr;
  ExprFunc(super.parameters,
      this.expr); // to be evaluated in executer as it is special
}

class SinFunc extends Func {
  SinFunc() : super([Parameter(ValueType("number"), "x")]);

  @override
  Value _evaluate(List<Value> arguments) {
    double x = (arguments[0] as NumberValue).value;
    return NumberValue(sin(x));
  }
}

class CosFunc extends Func {
  CosFunc() : super([Parameter(ValueType("number"), "x")]);

  @override
  Value _evaluate(List<Value> arguments) {
    double x = (arguments[0] as NumberValue).value;
    return NumberValue(cos(x));
  }
}

class TanFunc extends Func {
  TanFunc() : super([Parameter(ValueType("number"), "x")]);

  @override
  Value _evaluate(List<Value> arguments) {
    double x = (arguments[0] as NumberValue).value;
    return NumberValue(tan(x));
  }
}
