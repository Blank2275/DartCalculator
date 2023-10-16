import 'func.dart';
import 'value.dart';

class Context {
  StackFrame global = StackFrame();
  List<StackFrame> stack = [];

  Map<String, Func> functions = {};

  Value returnResult = EmptyValue();

  void addBlockLevel() {
    if (stack.length == 0) {
      global.addBlockLevel();
    } else {
      stack[stack.length - 1].addBlockLevel();
    }
  }

  void popBlockLevel() {
    if (stack.length == 0) {
      global.popBlockLevel();
    } else {
      stack[stack.length - 1].popBlockLevel();
    }
  }

  void addStackFrame() {
    stack.add(StackFrame());
  }

  void popStackFrame() {
    stack.removeAt(stack.length - 1);
  }

  void setVariable(String name, Value value) {
    if (stack.length == 0) {
      global.setVariable(name, value);
    } else {
      stack[stack.length - 1].setVariable(name, value);
    }
  }

  Value getVariable(String name) {
    Value value = lookupVariable(name);

    if (value is NullValue) return NullValue();
    if (value is EmptyValue) return EmptyValue();
    if (value is NumberValue) return NumberValue.clone(value);
    if (value is BooleanValue) return BooleanValue.clone(value);
    if (value is ArrayValue) return ArrayValue.clone(value);
    if (value is StringValue) return StringValue.clone(value);
    if (value is FunctionValue) return FunctionValue.clone(value);

    return NullValue();
  }

  Value getReferencedVariable(String name) {
    Value value = lookupVariable(name);

    return value;
  }

  Value lookupVariable(String name) {
    if (stack.length == 0) {
      Value globalValue = global.getVariable(name);

      if (globalValue is NullValue) {
        Func variableFunc = getFunction(name);

        if (!(variableFunc is NullFunc)) {
          return FunctionValue(name);
        }
      }

      return globalValue;
    } else {
      Value? stackValue = stack[stack.length - 1].getVariable(name);

      if (stackValue is NullValue) {
        Value globalValue = global.getVariable(name);

        if (globalValue is NullValue) {
          Func variableFunc = getFunction(name);

          if (!(variableFunc is NullFunc)) {
            return FunctionValue(name);
          }
        }

        return globalValue;
      } else {
        return stackValue;
      }
    }
  }

  void setFunction(String name, Func func) {
    functions[name] = func;
  }

  Func getFunction(String name) {
    Func? func = functions[name];

    if (func != null) return func;

    Value funcValue = lookupVariable(name);

    if (funcValue is FunctionValue) return functions[funcValue.value]!;

    return NullFunc();
  }
}

class StackFrame {
  Map<String, Value> variables = {};
  Map<String, int> blockLevels = {};

  void addBlockLevel() {
    for (String key in blockLevels.keys) {
      blockLevels[key] = blockLevels[key]! + 1;
    }
  }

  void popBlockLevel() {
    List<String> keys = blockLevels.keys.toList();
    for (String key in keys) {
      blockLevels[key] = blockLevels[key]! - 1;

      if (blockLevels[key]! == 0) {
        blockLevels.remove(key);
        variables.remove(key);
      }
    }
  }

  void setVariable(String name, Value value) {
    variables[name] = value;

    if (blockLevels[name] == null) {
      blockLevels[name] = 1;
    }
  }

  Value getVariable(String name) {
    Value? val = variables[name];

    if (val != null) return val;
    return NullValue();
  }
}

class StandardContext extends Context {
  StandardContext() {
    setFunction("sin", SinFunc());
    setFunction("cos", CosFunc());
    setFunction("tan", TanFunc());
    setFunction("add", AddFunc());
    setFunction("len", LenFunc());
    setFunction("get", GetFunc());
    setFunction("set", SetFunc());
    setFunction("range", RangeFunc());
    setFunction("typeof", TypeofFunc());
  }
}
