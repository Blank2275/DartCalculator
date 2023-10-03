import 'dart:io';

import 'Calc/Executing/runner.dart';

void main(List<String> args) async {
  File file = File(args[0]);

  String code = await file.readAsString();

  Runner runner = Runner();

  runner.runScript(code);
}
