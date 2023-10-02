import 'func.dart';
import 'value.dart';

class Context {
  StackFrame global = StackFrame();
  List<StackFrame> stack = [];

  Map<String, Func> functions = {};

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
    if (stack.length == 0) {
      Value globalValue = global.getVariable(name);

      return globalValue;
    } else {
      Value? stackValue = stack[stack.length - 1].getVariable(name);

      if (stackValue is NullValue) {
        Value globalValue = global.getVariable(name);

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
    return NullFunc();
  }
}

class StackFrame {
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

class StandardContext extends Context {
  StandardContext() {
    setFunction("sin", SinFunc());
  }
}
