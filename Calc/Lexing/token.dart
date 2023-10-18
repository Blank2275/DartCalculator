enum TokenType {
  NUMBER_LITERAL,
  IDENTIFIER_LITERAL,
  STRING_LITERAL,
  ADD,
  SUB,
  MUL,
  DIV,
  MOD,
  POW,
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
  DOLLAR,
  TERNARY,
  COLON,
  NULL,
  CURSOR_FILLER
}

class Token {
  TokenType type;
  String? value;
  int cursorIndex = 0;

  Token(this.type, this.value);

  @override
  String toString() {
    return "[$type $value]";
  }
}
