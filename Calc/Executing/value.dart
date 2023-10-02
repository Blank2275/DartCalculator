class Value {
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
}

class NullValue extends Value {}

class NumberValue extends Value {
  double value;

  NumberValue(this.value);

  Value add(Value other) {
    if (other is NumberValue) {
      return NumberValue(value + other.value);
    }
    return NullValue();
  }

  Value sub(Value other) {
    if (other is NumberValue) {
      return NumberValue(value - other.value);
    }
    return NullValue();
  }

  Value mul(Value other) {
    if (other is NumberValue) {
      return NumberValue(value * other.value);
    }
    return NullValue();
  }

  Value div(Value other) {
    if (other is NumberValue) {
      return NumberValue(value / other.value);
    }
    return NullValue();
  }

  @override
  String toString() {
    return "[NumberValue $value]";
  }
}
