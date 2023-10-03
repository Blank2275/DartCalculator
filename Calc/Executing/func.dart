import 'dart:math';

import '../Parsing/Parameter.dart';
import '../Parsing/Type.dart';
import '../Parsing/block.dart';
import '../Parsing/expression.dart';
import '../error.dart';
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

      if (typeName == "any") return true;
      if (arguments[i] is NumberValue && typeName != "number") return false;
      if (arguments[i] is BooleanValue && typeName != "boolean") return false;
      if (arguments[i] is ArrayValue && typeName != "array") return false;
      // if (arguments[i] is BooleanValue && typeName != "boolean") return false;
    }

    return true;
  }
}

class NullFunc extends Func {
  NullFunc() : super([]);

  @override
  Value _evaluate(List<Value> arguments) {
    runtimeError("Function not found");
    return NullValue();
  }
}

class ExprFunc extends Func {
  Expr expr;
  ExprFunc(super.parameters,
      this.expr); // to be evaluated in executer as it is special
}

class ScriptFunc extends Func {
  Block body;
  ScriptFunc(super.parameters,
      this.body); // to be evaluated in executer as it is special
}

class AddFunc extends Func {
  AddFunc()
      : super([
          Parameter(ValueType("array"), "arr"),
          Parameter(ValueType("any"), "val")
        ]);

  @override
  Value _evaluate(List<Value> arguments) {
    (arguments[0] as ArrayValue).value.add(arguments[1]);
    return NullValue();
  }
}

class LenFunc extends Func {
  LenFunc() : super([Parameter(ValueType("array"), "arr")]);

  @override
  Value _evaluate(List<Value> arguments) {
    List<Value> elements = (arguments[0] as ArrayValue).value;
    return NumberValue(elements.length.toDouble());
  }
}

class GetFunc extends Func {
  GetFunc()
      : super([
          Parameter(ValueType("array"), "arr"),
          Parameter(ValueType("number"), "index")
        ]);

  @override
  Value _evaluate(List<Value> arguments) {
    List<Value> elements = (arguments[0] as ArrayValue).value;
    return elements[(arguments[1] as NumberValue).value.round()];
  }
}

class SetFunc extends Func {
  SetFunc()
      : super([
          Parameter(ValueType("array"), "arr"),
          Parameter(ValueType("number"), "index"),
          Parameter(ValueType("any"), "newValue")
        ]);

  @override
  Value _evaluate(List<Value> arguments) {
    List<Value> elements = (arguments[0] as ArrayValue).value;
    elements[(arguments[1] as NumberValue).value.round()] = arguments[2];
    return NullValue();
  }
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
