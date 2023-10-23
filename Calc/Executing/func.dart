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
      return ErrorValue.type("Runtime Error", "invalid arguments");
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
      if (arguments[i] is FunctionValue && typeName != "function") return false;
      if (arguments[i] is StringValue && typeName != "string") return false;
      if (arguments[i] is NullValue && typeName != "nullType") return false;
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
    return (arguments[0] as ArrayValue);
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

class TypeofFunc extends Func {
  TypeofFunc() : super([Parameter(ValueType("any"), "val")]);

  @override
  Value _evaluate(List<Value> arguments) {
    Value val = arguments[0];

    if (val is NullValue) {
      return StringValue("null");
    } else if (val is EmptyValue) {
      return StringValue('empty');
    } else if (val is NumberValue) {
      return StringValue("number");
    } else if (val is BooleanValue) {
      return StringValue("boolean");
    } else if (val is ArrayValue) {
      return StringValue("array");
    } else if (val is StringValue) {
      return StringValue("string");
    } else if (val is FunctionValue) {
      return StringValue("function");
    }

    return StringValue("Should not print, check typeof func");
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
    int index = (arguments[1] as NumberValue).value.round();

    if (index < 0 || index >= elements.length) {
      return ErrorValue.type("Runtime Error",
          "index $index out of bounds for array of length ${elements.length}");
    }

    return elements[index];
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
    int index = (arguments[1] as NumberValue).value.round();

    if (index < 0 || index >= elements.length) {
      return ErrorValue.type("Runtime Error",
          "index $index out of bounds for array of length ${elements.length}");
    }

    elements[index] = arguments[2];
    return ArrayValue(elements);
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

class ASinFunc extends Func {
  ASinFunc() : super([Parameter(ValueType("number"), "x")]);

  @override
  Value _evaluate(List<Value> arguments) {
    double x = (arguments[0] as NumberValue).value;
    return NumberValue(asin(x));
  }
}

class ACosFunc extends Func {
  ACosFunc() : super([Parameter(ValueType("number"), "x")]);

  @override
  Value _evaluate(List<Value> arguments) {
    double x = (arguments[0] as NumberValue).value;
    return NumberValue(acos(x));
  }
}

class ATanFunc extends Func {
  ATanFunc() : super([Parameter(ValueType("number"), "x")]);

  @override
  Value _evaluate(List<Value> arguments) {
    double x = (arguments[0] as NumberValue).value;
    return NumberValue(atan(x));
  }
}

class SecFunc extends Func {
  SecFunc() : super([Parameter(ValueType("number"), "x")]);

  @override
  Value _evaluate(List<Value> arguments) {
    double x = (arguments[0] as NumberValue).value;
    return NumberValue(1 / cos(x));
  }
}

class CscFunc extends Func {
  CscFunc() : super([Parameter(ValueType("number"), "x")]);

  @override
  Value _evaluate(List<Value> arguments) {
    double x = (arguments[0] as NumberValue).value;
    return NumberValue(1 / sin(x));
  }
}

class CotFunc extends Func {
  CotFunc() : super([Parameter(ValueType("number"), "x")]);

  @override
  Value _evaluate(List<Value> arguments) {
    double x = (arguments[0] as NumberValue).value;
    return NumberValue(1 / tan(x));
  }
}

class ASecFunc extends Func {
  ASecFunc() : super([Parameter(ValueType("number"), "x")]);

  @override
  Value _evaluate(List<Value> arguments) {
    double x = (arguments[0] as NumberValue).value;
    return NumberValue(acos(1 / x));
  }
}

class ACscFunc extends Func {
  ACscFunc() : super([Parameter(ValueType("number"), "x")]);

  @override
  Value _evaluate(List<Value> arguments) {
    double x = (arguments[0] as NumberValue).value;
    return NumberValue(asin(1 / x));
  }
}

class ACotFunc extends Func {
  ACotFunc() : super([Parameter(ValueType("number"), "x")]);

  @override
  Value _evaluate(List<Value> arguments) {
    double x = (arguments[0] as NumberValue).value;
    return NumberValue(atan(1 / x));
  }
}

class SqrtFunc extends Func {
  SqrtFunc() : super([Parameter(ValueType("number"), "x")]);

  @override
  Value _evaluate(List<Value> arguments) {
    double x = (arguments[0] as NumberValue).value;
    return NumberValue(sqrt(x));
  }
}

class NRootFunc extends Func {
  NRootFunc()
      : super([
          Parameter(ValueType("number"), "n"),
          Parameter(ValueType("number"), "x")
        ]);

  @override
  Value _evaluate(List<Value> arguments) {
    double n = (arguments[0] as NumberValue).value;
    double x = (arguments[0] as NumberValue).value;
    return NumberValue(pow(x, 1 / n) as double);
  }
}

class RangeFunc extends Func {
  RangeFunc()
      : super([
          Parameter(ValueType("number"), "start"),
          Parameter(ValueType("number"), "stop"),
          Parameter(ValueType("number"), "step")
        ]);

  @override
  Value _evaluate(List<Value> arguments) {
    List<Value> range = [];

    double start = (arguments[0] as NumberValue).value;
    double stop = (arguments[1] as NumberValue).value;
    double step = (arguments[2] as NumberValue).value;

    if (start == stop ||
        (start < stop && step < 0) ||
        (start > stop && step > 0)) return ArrayValue([]);

    if (start < stop) {
      while (start < stop) {
        range.add(NumberValue(start));
        start += step;
      }
    } else {
      while (start > stop) {
        range.add(NumberValue(start));
        start += step;
      }
    }

    return ArrayValue(range);
  }
}
