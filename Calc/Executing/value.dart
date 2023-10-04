class Value {
  Value();

  Value.clone(Value value) : this();

  Value add(Value other) {
    return ErrorValue("");
  }

  Value sub(Value other) {
    return ErrorValue("");
  }

  Value mul(Value other) {
    return ErrorValue("");
  }

  Value div(Value other) {
    return ErrorValue("");
  }

  Value gt(Value other) {
    return ErrorValue("");
  }

  Value lt(Value other) {
    return ErrorValue("");
  }

  Value ge(Value other) {
    return ErrorValue("");
  }

  Value le(Value other) {
    return ErrorValue("");
  }

  Value eq(Value other) {
    return ErrorValue("");
  }

  Value ne(Value other) {
    return ErrorValue("");
  }

  Value and(Value other) {
    return ErrorValue("");
  }

  Value or(Value other) {
    return ErrorValue("");
  }
}

class ErrorValue extends Value {
  String message = "";
  String type = "Type Error";

  ErrorValue(this.message);

  ErrorValue.type(this.type, this.message);
}

class NullValue extends Value {
  NullValue();

  NullValue.clone(NullValue other) : this();

  @override
  String toString() {
    return "null";
  }

  Value add(Value other) {
    return ErrorValue("cannot add null");
  }

  Value sub(Value other) {
    return ErrorValue("cannot subtact null");
  }

  Value mul(Value other) {
    return ErrorValue("cannot multiply null");
  }

  Value div(Value other) {
    return ErrorValue("cannot divide null");
  }

  Value gt(Value other) {
    return ErrorValue("cannot compare null");
  }

  Value lt(Value other) {
    return ErrorValue("cannot compare null");
  }

  Value ge(Value other) {
    return ErrorValue("cannot compare null");
  }

  Value le(Value other) {
    return ErrorValue("cannot compare null");
  }

  Value eq(Value other) {
    if (other is NullValue) {
      return BooleanValue(true);
    }

    return BooleanValue(false);
  }

  Value ne(Value other) {
    if (other is NullValue) {
      return BooleanValue(false);
    }

    return BooleanValue(true);
  }

  Value and(Value other) {
    return ErrorValue("cannot perform and operation with a non boolean");
  }

  Value or(Value other) {
    return ErrorValue("cannot perform or operation with a non boolean");
  }
}

class EmptyValue extends Value {
  EmptyValue();

  EmptyValue.clone(EmptyValue other) : this();

  Value add(Value other) {
    return ErrorValue("cannot add empty");
  }

  Value sub(Value other) {
    return ErrorValue("cannot subtact empty");
  }

  Value mul(Value other) {
    return ErrorValue("cannot multiply empty");
  }

  Value div(Value other) {
    return ErrorValue("cannot divide empty");
  }

  Value gt(Value other) {
    return ErrorValue("cannot compare empty");
  }

  Value lt(Value other) {
    return ErrorValue("cannot compare empty");
  }

  Value ge(Value other) {
    return ErrorValue("cannot compare empty");
  }

  Value le(Value other) {
    return ErrorValue("cannot compare empty");
  }

  Value eq(Value other) {
    if (other is NullValue) {
      return BooleanValue(true);
    }

    return BooleanValue(false);
  }

  Value ne(Value other) {
    if (other is NullValue) {
      return BooleanValue(false);
    }

    return BooleanValue(true);
  }

  Value and(Value other) {
    return ErrorValue("cannot perform and operation with a non boolean");
  }

  Value or(Value other) {
    return ErrorValue("cannot perform or operation with a non boolean");
  }

  @override
  String toString() {
    return "empty";
  }
}

class StringValue extends Value {
  String value;

  StringValue(this.value);

  StringValue.clone(StringValue other) : this(other.value);

  Value add(Value other) {
    return ErrorValue("cannot add strings");
  }

  Value sub(Value other) {
    return ErrorValue("cannot subtract strings");
  }

  Value mul(Value other) {
    return ErrorValue("cannot multiply strings");
  }

  Value div(Value other) {
    return ErrorValue("cannot divide strings");
  }

  Value gt(Value other) {
    return ErrorValue("cannot compare strings");
  }

  Value lt(Value other) {
    return ErrorValue("cannot compare strings");
  }

  Value ge(Value other) {
    return ErrorValue("cannot compare strings");
  }

  Value le(Value other) {
    return ErrorValue("cannot compare strings");
  }

  Value eq(Value other) {
    if (other is StringValue) {
      return BooleanValue(value == other.value);
    }

    return BooleanValue(false);
  }

  Value ne(Value other) {
    if (other is StringValue) {
      return BooleanValue(value != other.value);
    }

    return BooleanValue(true);
  }

  Value and(Value other) {
    return ErrorValue("cannot perform and operation with a non boolean");
  }

  Value or(Value other) {
    return ErrorValue("cannot perform or operation with a non boolean");
  }

  @override
  String toString() {
    return value;
  }
}

class BooleanValue extends Value {
  bool value;

  BooleanValue(this.value);

  BooleanValue.clone(BooleanValue other) : this(other.value);

  Value add(Value other) {
    return ErrorValue("cannot add a boolean");
  }

  Value sub(Value other) {
    return ErrorValue("cannot subtract a boolean");
  }

  Value mul(Value other) {
    return ErrorValue("cannot multipy a boolean");
  }

  Value div(Value other) {
    return ErrorValue("cannot divide a boolean");
  }

  Value gt(Value other) {
    return ErrorValue("cannot compare a boolean");
  }

  Value lt(Value other) {
    return ErrorValue("cannot compare a boolean");
  }

  Value ge(Value other) {
    return ErrorValue("cannot compare a boolean");
  }

  Value le(Value other) {
    return ErrorValue("cannot compare a boolean");
  }

  Value eq(Value other) {
    if (other is BooleanValue) {
      return BooleanValue(value == other.value);
    }

    return BooleanValue(false);
  }

  Value ne(Value other) {
    if (other is BooleanValue) {
      return BooleanValue(value != other.value);
    }

    return BooleanValue(true);
  }

  Value and(Value other) {
    if (other is BooleanValue) {
      return BooleanValue(value && other.value);
    }

    return ErrorValue("cannot perform and operation with a non boolean");
  }

  Value or(Value other) {
    if (other is BooleanValue) {
      return BooleanValue(value || other.value);
    }

    return ErrorValue("cannot perform or operation with a non boolean");
  }

  @override
  String toString() {
    return "$value";
  }
}

class NumberValue extends Value {
  double value;

  NumberValue(this.value);

  NumberValue.clone(NumberValue other) : this(other.value);

  Value add(Value other) {
    if (other is NumberValue) {
      return NumberValue(value + other.value);
    } else if (other is ArrayValue) {
      List<Value> res = [];

      for (Value element in other.value) {
        res.add(this.add(element));
      }

      return ArrayValue(res);
    }
    return ErrorValue("Can only add numbers with other numbers or arrays");
  }

  Value sub(Value other) {
    if (other is NumberValue) {
      return NumberValue(value - other.value);
    } else if (other is ArrayValue) {
      List<Value> res = [];

      for (Value element in other.value) {
        res.add(this.sub(element));
      }

      return ArrayValue(res);
    }
    return ErrorValue("Can only subtract numbers with other numbers or arrays");
  }

  Value mul(Value other) {
    if (other is NumberValue) {
      return NumberValue(value * other.value);
    } else if (other is ArrayValue) {
      List<Value> res = [];

      for (Value element in other.value) {
        res.add(this.mul(element));
      }

      return ArrayValue(res);
    }
    return ErrorValue("Can only multipy numbers with other numbers or arrays");
  }

  Value div(Value other) {
    if (other is NumberValue) {
      return NumberValue(value / other.value);
    } else if (other is ArrayValue) {
      List<Value> res = [];

      for (Value element in other.value) {
        res.add(this.div(element));
      }

      return ArrayValue(res);
    }
    return ErrorValue("Can only divide numbers with other numbers or arrays");
  }

  Value gt(Value other) {
    if (other is NumberValue) {
      return BooleanValue(value > other.value);
    } else if (other is ArrayValue) {
      List<Value> res = [];

      for (Value element in other.value) {
        res.add(this.gt(element));
      }

      return ArrayValue(res);
    }

    return ErrorValue("Can only compare numbers with other numbers or arrays");
  }

  Value lt(Value other) {
    if (other is NumberValue) {
      return BooleanValue(value < other.value);
    } else if (other is ArrayValue) {
      List<Value> res = [];

      for (Value element in other.value) {
        res.add(this.lt(element));
      }

      return ArrayValue(res);
    }

    return ErrorValue("Can only compare numbers with other numbers or arrays");
  }

  Value ge(Value other) {
    if (other is NumberValue) {
      return BooleanValue(value >= other.value);
    } else if (other is ArrayValue) {
      List<Value> res = [];

      for (Value element in other.value) {
        res.add(this.ge(element));
      }

      return ArrayValue(res);
    }

    return ErrorValue("Can only compare numbers with other numbers or arrays");
  }

  Value le(Value other) {
    if (other is NumberValue) {
      return BooleanValue(value <= other.value);
    } else if (other is ArrayValue) {
      List<Value> res = [];

      for (Value element in other.value) {
        res.add(this.le(element));
      }

      return ArrayValue(res);
    }

    return ErrorValue("Can only compare numbers with other numbers or arrays");
  }

  Value eq(Value other) {
    if (other is NumberValue) {
      return BooleanValue(value == other.value);
    }

    return BooleanValue(false);
  }

  Value ne(Value other) {
    if (other is NumberValue) {
      return BooleanValue(value != other.value);
    }

    return BooleanValue(true);
  }

  Value and(Value other) {
    return ErrorValue("cannot perform and operation with a non boolean");
  }

  Value or(Value other) {
    return ErrorValue("cannot perform or operation with a non boolean");
  }

  @override
  String toString() {
    return "$value";
  }
}

class ArrayValue extends Value {
  List<Value> value;

  ArrayValue(this.value);

  ArrayValue.clone(ArrayValue other) : this(List.from(other.value));

  Value add(Value other) {
    List<Value> res = [];
    if (other is NumberValue) {
      for (Value element in value) {
        res.add(element.add(other));
      }

      return ArrayValue(res);
    }
    return ErrorValue("can only do element wise addition with numbers");
  }

  Value sub(Value other) {
    List<Value> res = [];
    if (other is NumberValue) {
      for (Value element in value) {
        res.add(element.sub(other));
      }

      return ArrayValue(res);
    }
    return ErrorValue("can only do element wise subtraction with numbers");
  }

  Value mul(Value other) {
    List<Value> res = [];
    if (other is NumberValue) {
      for (Value element in value) {
        res.add(element.mul(other));
      }

      return ArrayValue(res);
    }
    return ErrorValue("can only do element wise multiplication with numbers");
  }

  Value div(Value other) {
    List<Value> res = [];
    if (other is NumberValue) {
      for (Value element in value) {
        res.add(element.div(other));
      }

      return ArrayValue(res);
    }
    return ErrorValue("can only do element wise division with numbers");
  }

  Value gt(Value other) {
    List<Value> res = [];
    if (other is NumberValue) {
      for (Value element in value) {
        res.add(element.gt(other));
      }

      return ArrayValue(res);
    }
    return ErrorValue("can only do element wise comparison with numbers");
  }

  Value lt(Value other) {
    List<Value> res = [];
    if (other is NumberValue) {
      for (Value element in value) {
        res.add(element.lt(other));
      }

      return ArrayValue(res);
    }
    return ErrorValue("can only do element wise comparison with numbers");
  }

  Value ge(Value other) {
    List<Value> res = [];
    if (other is NumberValue) {
      for (Value element in value) {
        res.add(element.ge(other));
      }

      return ArrayValue(res);
    }
    return ErrorValue("can only do element wise comparison with numbers");
  }

  Value le(Value other) {
    List<Value> res = [];
    if (other is NumberValue) {
      for (Value element in value) {
        res.add(element.le(other));
      }

      return ArrayValue(res);
    }
    return ErrorValue("can only do element wise comparison with numbers");
  }

  Value eq(Value other) {
    if (other is ArrayValue) {
      if (value.length != other.value.length) return BooleanValue(false);

      for (int i = 0; i < value.length; i++) {
        if (!(value[i].eq(other.value[i]) as BooleanValue).value)
          return BooleanValue(false);
      }

      return BooleanValue(true);
    }

    return BooleanValue(false);
  }

  Value ne(Value other) {
    if (other is ArrayValue) {
      if (value.length != other.value.length) return BooleanValue(false);

      for (int i = 0; i < value.length; i++) {
        if (!(value[i].eq(other.value[i]) as BooleanValue).value)
          return BooleanValue(true);
      }

      return BooleanValue(false);
    }

    return BooleanValue(true);
  }

  Value and(Value other) {
    return ErrorValue("cannot perform and operation with a non boolean");
  }

  Value or(Value other) {
    return ErrorValue("cannot perform or operation with a non boolean");
  }

  @override
  String toString() {
    return "$value";
  }
}
