import 'dart:io';

import 'Calc/Executing/executer.dart';
import 'Calc/Executing/runner.dart';
import 'Calc/Lexing/lexer.dart';
import 'Calc/Parsing/scriptParser.dart';

void main(List<String> args) async {
  Executer executer = Executer();

  final stdDir = Directory('./standardLibrary');
  final List<FileSystemEntity> entities = await stdDir.list().toList();

  final Iterable<File> files = entities.whereType<File>();

  for (File file in files) {
    String code = await file.readAsString();

    executer.loadContext(code);
  }

  File file = File(args[0]);

  String code = await file.readAsString();

  executer.runProgram(ScriptParser(lex(code)).parseAll());
}
