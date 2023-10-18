import 'dart:math';

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
  List<String> reservedWords = ["if", "else", "fun"];

  Parser(this.tokens);

  bool isAtEnd() {
    return current >= tokens.length;
  }

  Token previous() {
    if (current == 0) return Token(TokenType.NULL, null);
    return tokens[current - 1];
  }

  Token advance() {
    if (isAtEnd()) return Token(TokenType.NULL, null);
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
      if (peek().type == TokenType.IDENTIFIER_LITERAL &&
          (reservedWords.contains(peek().value))) return false;
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

  void expectIdentifier(String identifier, String message) {
    if (peek().type == TokenType.IDENTIFIER_LITERAL &&
        peek().value == identifier) {
      advance();
      return;
    }

    parseError(message);
  }

  List<Expr> parseExpressions() {
    List<Expr> exprs = [];
    while (!isAtEnd()) {
      exprs.add(parseExpression());
    }

    return exprs;
  }

  Decl parseDeclaration() {
    if (peek().type == TokenType.IDENTIFIER_LITERAL) {
      if (peek().value == "fun") {
        advance();
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

    Expr body = parseExpression();

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
      if (peek().value == "if") {
        advance();
        return parseIfElse();
      } else if (peekNext()?.type == TokenType.ASSIGNMENT) {
        return assignment();
      }
    }

    return ExprStmt(parseExpression());
  }

  Stmt parseIfElse() {
    expect(TokenType.LPAREN, "Expected opening '(' in if statement condition");
    Expr condition = parseExpression();
    expect(TokenType.RPAREN, "Expected closing ')' in if statement condition");

    Stmt onTrue = parseStatement();

    expectIdentifier("else", "Expected else case in if statement");

    Stmt onFalse = parseStatement();

    return IfElseStmt(condition, onTrue, onFalse);
  }

  Stmt assignment() {
    Token name = advance();

    expect(TokenType.ASSIGNMENT, "should not print, check parseStatement");

    Expr value = parseExpression();

    return AssignmentStmt(name, value);
  }

  Expr parseExpression() {
    if (isAtEnd()) return NullExpr();
    return ternary();
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
          arguments.add(ternary());

          while (match([TokenType.COMMA])) {
            arguments.add(ternary());
          }
          expect(TokenType.RPAREN, "expected closing parenthace");
          return FuncCallExpr(t, arguments);
        }
        return IdentifierExpr(t);
      }
    } else if (t.type == TokenType.LPAREN) {
      Expr child = ternary();
      expect(TokenType.RPAREN, "expected closing parenthace");

      return GroupingExpr(child);
    } else if (t.type == TokenType.LBRACKET) {
      List<Expr> elements = [];

      if (!match([TokenType.RBRACKET])) {
        elements.add(ternary());

        while (match([TokenType.COMMA])) {
          elements.add(ternary());
        }

        expect(TokenType.RBRACKET, "expecting closing bracket");
      }

      return ArrayExpr(elements);
    } else if (t.type == TokenType.CURSOR_FILLER) {
      return CursorExpr();
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

  Expr _power() {
    Expr expr = unary();

    while (match([TokenType.POW])) {
      Token op = previous();
      Expr right = unary();

      expr = BinaryExpr(expr, right, op);
    }

    return expr;
  }

  Expr factor() {
    Expr expr = _power();

    while (match([TokenType.MUL, TokenType.DIV, TokenType.MOD])) {
      Token op = previous();
      Expr right = _power();

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

  Expr ternary() {
    Expr expr = conjunction();

    if (match([TokenType.TERNARY])) {
      Expr onTrue = ternary();

      expect(TokenType.COLON, "Expected ':' in ternary operation");

      Expr onFalse = ternary();

      expr = TernaryExpr(expr, onTrue, onFalse);
    }

    return expr;
  }
}
