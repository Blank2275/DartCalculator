import 'token.dart';

List<Token> lex(String text) {
  List<Token> tokens = [];
  int position = 0;

  bool isAtEnd() {
    return position >= text.length;
  }

  bool isNumeric(String c) {
    if (c.isEmpty) return false;
    return "0123456789".contains(c);
  }

  bool isAlpha(String c) {
    if (c.isEmpty) return false;
    return "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ".contains(c);
  }

  bool isAlphaNumeric(String c) {
    return isAlpha(c) || isNumeric(c);
  }

  String consume() {
    if (isAtEnd()) return "";
    position += 1;
    return text[position - 1];
  }

  String peek() {
    if (isAtEnd()) return "";
    return text[position];
  }

  String peekNext() {
    if (position >= text.length - 1) return "";
    return text[position + 1];
  }

  String previous() {
    return text[position - 1];
  }

  bool match(String char) {
    if (peek() == char) {
      position += 1;
      return true;
    }
    return false;
  }

  void number() {
    String string = previous();

    while (isNumeric(peek())) {
      string += consume();
    }

    if (peek() == ".") {
      string += consume();

      while (isNumeric(peek())) {
        string += consume();
      }
    }

    tokens.add(Token(TokenType.NUMBER_LITERAL, string));
  }

  void identifier() {
    String string = previous();

    while (isAlphaNumeric(peek())) {
      string += consume();
    }

    tokens.add(Token(TokenType.IDENTIFIER_LITERAL, string));
  }

  while (!isAtEnd()) {
    String c = consume();
    switch (c) {
      case "+":
        tokens.add(Token(TokenType.ADD, null));
        break;
      case "-":
        tokens.add(Token(TokenType.SUB, null));
        break;
      case "*":
        tokens.add(Token(TokenType.MUL, null));
        break;
      case "/":
        tokens.add(Token(TokenType.DIV, null));
        break;
      case "^":
        tokens.add(Token(TokenType.POW, null));
        break;
      case "%":
        tokens.add(Token(TokenType.MOD, null));
        break;
      case "(":
        tokens.add(Token(TokenType.LPAREN, null));
        break;
      case ")":
        tokens.add(Token(TokenType.RPAREN, null));
        break;
      case "[":
        tokens.add(Token(TokenType.LBRACKET, null));
        break;
      case "]":
        tokens.add(Token(TokenType.RBRACKET, null));
        break;
      case ",":
        tokens.add(Token(TokenType.COMMA, null));
        break;
      case "%":
        tokens.add(Token(TokenType.MOD, null));
        break;
      case "\$":
        tokens.add(Token(TokenType.DOLLAR, null));
        break;
      case "?":
        tokens.add(Token(TokenType.TERNARY, null));
      case ":":
        tokens.add(Token(TokenType.COLON, null));
      case "&":
        if (match("&")) {
          tokens.add(Token(TokenType.AND, null));
        }
        break;
      case "|":
        if (match("|")) {
          tokens.add(Token(TokenType.OR, null));
        }
        break;
      case "=":
        if (match("=")) {
          tokens.add(Token(TokenType.EQ, null));
        } else {
          tokens.add(Token(TokenType.ASSIGNMENT, null));
        }
        break;
      case ">":
        if (match("=")) {
          tokens.add(Token(TokenType.GE, null));
        } else {
          tokens.add(Token(TokenType.GT, null));
        }
        break;
      case "<":
        if (match("=")) {
          tokens.add(Token(TokenType.LE, null));
        } else {
          tokens.add(Token(TokenType.LT, null));
        }
        break;
      case "!":
        if (match("=")) {
          tokens.add(Token(TokenType.NE, null));
        } else {
          tokens.add(Token(TokenType.NOT, null));
        }
        break;
      case ".":
        tokens.add(Token(TokenType.PERIOD, null));
        break;
      case "\"":
        String val = "";

        while (!isAtEnd() && consume() != "\"") {
          val += previous();
        }

        tokens.add(Token(TokenType.STRING_LITERAL, val));
      default:
        if (isNumeric(c)) {
          number();
        } else if (isAlpha(c)) {
          identifier();
        }
    }
  }

  return tokens;
}
