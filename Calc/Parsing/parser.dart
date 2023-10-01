import '../error.dart';
import 'Parameter.dart';
import 'Type.dart';
import 'declaration.dart';
import 'expression.dart';
import '../Lexing/token.dart';
import 'statement.dart';

class Parser {
  int current = 0;
  List<Token> tokens;

  Parser(this.tokens);

  bool isAtEnd() {
    return current >= tokens.length;
  }

  Token previous() {
    return tokens[current - 1];
  }

  Token advance() {
    current += 1;

    return previous();
  }

  Token peek() {
    return tokens[current];
  }

  Token? peekNext() {
    if (current >= tokens.length - 1) return null;
    return tokens[current + 1];
  }

  bool match(List<TokenType> targets) {
    if (isAtEnd()) return false;

    for (TokenType target in targets) {
      if (peek().type == target) {
        advance();
        return true;
      }
    }

    return false;
  }

  void expect(TokenType type, String message) {
    if (match([type])) return;

    parseError(message);
  }

  Decl parseDeclaration() {
    if (match([TokenType.IDENTIFIER_LITERAL])) {
      if (previous().value == "fun") {
        return functionDeclaration();
      }
    }

    return StmtDecl(parseStatement());
  }

  Decl functionDeclaration() {
    Token name = advance();

    expect(TokenType.LPAREN, "Invalid function declaration");

    List<Parameter> parameters = [];

    if (!match([TokenType.RPAREN])) {
      parameters.add(parseParameter());

      while (match([TokenType.COMMA])) {
        parameters.add(parseParameter());
      }

      expect(TokenType.RPAREN, "Invalid function declaration");
    }

    expect(TokenType.ASSIGNMENT, "Invalid function declaration");

    Stmt body = parseStatement();

    return FuncDecl(name, parameters, body);
  }

  Parameter parseParameter() {
    expect(TokenType.IDENTIFIER_LITERAL, "Expected parameter");
    Token first = previous();

    if (match([TokenType.IDENTIFIER_LITERAL])) {
      return Parameter(ValueType(first.value!), previous().value!);
    }

    return Parameter(ValueType("number"), first.value!);
  }

  Stmt parseStatement() {
    if (peek().type == TokenType.IDENTIFIER_LITERAL) {
      if (peekNext()?.type == TokenType.ASSIGNMENT) {
        return assignment();
      }
    }

    return ExprStmt(parseExpression());
  }

  Stmt assignment() {
    Token name = advance();

    expect(TokenType.ASSIGNMENT, "should not print, check parseStatement");

    Expr value = parseExpression();

    return AssignmentStmt(name, value);
  }

  Expr parseExpression() {
    return conjunction();
  }

  Expr value() {
    Token t = advance();

    if (t.type == TokenType.NUMBER_LITERAL) {
      return NumberExpr(t);
    } else if (t.type == TokenType.IDENTIFIER_LITERAL) {
      if (t.value == "true" || t.value == "false") {
        return BooleanExpr(t);
      } else {
        if (match([TokenType.LPAREN])) {
          List<Expr> arguments = [];
          arguments.add(conjunction());

          while (match([TokenType.COMMA])) {
            arguments.add(conjunction());
          }
          expect(TokenType.RPAREN, "expected closing parenthace");
          return FuncCallExpr(t, arguments);
        }
        return IdentifierExpr(t);
      }
    } else if (t.type == TokenType.LPAREN) {
      Expr child = conjunction();
      expect(TokenType.RPAREN, "expected closing parenthace");

      return GroupingExpr(child);
    } else if (t.type == TokenType.LBRACKET) {
      List<Expr> elements = [];

      if (!match([TokenType.RBRACKET])) {
        elements.add(conjunction());

        while (match([TokenType.COMMA])) {
          elements.add(conjunction());
        }

        expect(TokenType.RBRACKET, "expecting closing bracket");
      }

      return ArrayExpr(elements);
    }

    return NullExpr();
  }

  Expr unary() {
    if (match([TokenType.NOT, TokenType.SUB])) {
      Token op = previous();
      Expr expr = UnaryExpr(value(), op);
      while (match([TokenType.NOT, TokenType.SUB])) {
        Token op = previous();

        expr = UnaryExpr(expr, op);
      }
      return expr;
    } else {
      return value();
    }
  }

  Expr factor() {
    Expr expr = unary();

    while (match([TokenType.MUL, TokenType.DIV])) {
      Token op = previous();
      Expr right = unary();

      expr = BinaryExpr(expr, right, op);
    }

    return expr;
  }

  Expr term() {
    Expr expr = factor();

    while (match([TokenType.ADD, TokenType.SUB])) {
      Token op = previous();
      Expr right = factor();

      expr = BinaryExpr(expr, right, op);
    }

    return expr;
  }

  Expr comparison() {
    Expr expr = term();

    while (match([
      TokenType.GT,
      TokenType.LT,
      TokenType.GE,
      TokenType.LE,
    ])) {
      Token op = previous();
      Expr right = term();

      expr = BinaryExpr(expr, right, op);
    }

    return expr;
  }

  Expr equality() {
    Expr expr = comparison();

    while (match([TokenType.EQ, TokenType.NE])) {
      Token op = previous();
      Expr right = comparison();

      expr = BinaryExpr(expr, right, op);
    }

    return expr;
  }

  Expr conjunction() {
    Expr expr = equality();

    while (match([TokenType.AND, TokenType.OR])) {
      Token op = previous();
      Expr right = equality();

      expr = BinaryExpr(expr, right, op);
    }

    return expr;
  }
}
