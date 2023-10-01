enum TokenType {
  NUMBER_LITERAL,
  IDENTIFIER_LITERAL,
  ADD,
  SUB,
  MUL,
  DIV,
  MOD,
  LT,
  GT,
  LE,
  GE,
  AND,
  OR,
  NOT,
  LPAREN,
  RPAREN,
  COMMA,
  EQ,
  NE,
  ASSIGNMENT,
  LBRACKET,
  RBRACKET,
  PERIOD,
  DOLLAR
}

class Token {
  TokenType type;
  String? value;

  Token(this.type, this.value);

  @override
  String toString() {
    return "[$type $value]";
  }
}
