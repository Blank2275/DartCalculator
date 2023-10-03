class Value {
  Value();

  Value.clone(Value value) : this();

  Value add(Value other) {
    return NullValue();
  }

  Value sub(Value other) {
    return NullValue();
  }

  Value mul(Value other) {
    return NullValue();
  }

  Value div(Value other) {
    return NullValue();
  }

  Value gt(Value other) {
    return NullValue();
  }

  Value lt(Value other) {
    return NullValue();
  }

  Value ge(Value other) {
    return NullValue();
  }

  Value le(Value other) {
    return NullValue();
  }

  Value eq(Value other) {
    return NullValue();
  }

  Value ne(Value other) {
    return NullValue();
  }

  Value and(Value other) {
    return NullValue();
  }

  Value or(Value other) {
    return NullValue();
  }
}

class NullValue extends Value {
  NullValue();

  NullValue.clone(NullValue other) : this();

  @override
  String toString() {
    return "null";
  }
}

class EmptyValue extends Value {
  EmptyValue();

  EmptyValue.clone(EmptyValue other) : this();
}

class BooleanValue extends Value {
  bool value;

  BooleanValue(this.value);

  BooleanValue.clone(BooleanValue other) : this(other.value);

  Value add(Value other) {
    return NullValue();
  }

  Value sub(Value other) {
    return NullValue();
  }

  Value mul(Value other) {
    return NullValue();
  }

  Value div(Value other) {
    return NullValue();
  }

  Value gt(Value other) {
    return NullValue();
  }

  Value lt(Value other) {
    return NullValue();
  }

  Value ge(Value other) {
    return NullValue();
  }

  Value le(Value other) {
    return NullValue();
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

    return NullValue();
  }

  Value or(Value other) {
    if (other is BooleanValue) {
      return BooleanValue(value || other.value);
    }

    return NullValue();
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
    return NullValue();
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
    return NullValue();
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
    return NullValue();
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
    return NullValue();
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

    return NullValue();
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

    return NullValue();
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

    return NullValue();
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

    return NullValue();
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
    return NullValue();
  }

  Value or(Value other) {
    return NullValue();
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
    return NullValue();
  }

  Value sub(Value other) {
    List<Value> res = [];
    if (other is NumberValue) {
      for (Value element in value) {
        res.add(element.sub(other));
      }

      return ArrayValue(res);
    }
    return NullValue();
  }

  Value mul(Value other) {
    List<Value> res = [];
    if (other is NumberValue) {
      for (Value element in value) {
        res.add(element.mul(other));
      }

      return ArrayValue(res);
    }
    return NullValue();
  }

  Value div(Value other) {
    List<Value> res = [];
    if (other is NumberValue) {
      for (Value element in value) {
        res.add(element.div(other));
      }

      return ArrayValue(res);
    }
    return NullValue();
  }

  Value gt(Value other) {
    List<Value> res = [];
    if (other is NumberValue) {
      for (Value element in value) {
        res.add(element.gt(other));
      }

      return ArrayValue(res);
    }
    return NullValue();
  }

  Value lt(Value other) {
    List<Value> res = [];
    if (other is NumberValue) {
      for (Value element in value) {
        res.add(element.lt(other));
      }

      return ArrayValue(res);
    }
    return NullValue();
  }

  Value ge(Value other) {
    List<Value> res = [];
    if (other is NumberValue) {
      for (Value element in value) {
        res.add(element.ge(other));
      }

      return ArrayValue(res);
    }
    return NullValue();
  }

  Value le(Value other) {
    List<Value> res = [];
    if (other is NumberValue) {
      for (Value element in value) {
        res.add(element.le(other));
      }

      return ArrayValue(res);
    }
    return NullValue();
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
    return NullValue();
  }

  Value or(Value other) {
    return NullValue();
  }

  @override
  String toString() {
    return "$value";
  }
}
