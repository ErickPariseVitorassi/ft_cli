import 'dart:io';

import 'package:js_cli/core/errors/file_exists_error.dart';
import 'package:js_cli/core/utils/directory_utils.dart';
import 'package:js_cli/core/utils/global_variable.dart';
import 'package:js_cli/core/utils/output_utils.dart';
import 'package:js_cli/core/utils/reserved_words.dart';
import 'package:js_cli/core/utils/triggers_utils.dart';
import 'package:js_cli/models/entities/design_pattern/design_pattern.dart';
import 'package:path/path.dart' as p;

class DesignPatternController {
  static Future<bool> call(
    DesignPattern designPattern,
  ) async {
    final inputPath = GlobalVariable.path;

    var path = _replaceWordsInFile(
      designPattern.path(),
    );
    var nameFile = _replaceWordsInFile(
      designPattern.nameFile(),
    );
    var templete = _replaceWordsInFile(
      designPattern.template(),
    );
    var extension = designPattern.extension();

    var completePath = p.normalize(
      '$inputPath/$path/$nameFile.$extension',
    );

    DirectoryUtils.create(
      p.normalize(inputPath + '/' + path),
    );

    if (File(completePath).existsSync()) {
      error('exist file: $nameFile.$extension....');
      throw FileExistsError(innerException: Exception());
    }

    warn('generating $nameFile.$extension....');

    File(completePath).writeAsStringSync(templete);
    warn('create file $completePath....');

    await TriggersUtils.applyIfNecessary(
      root: 'template',
      subPath: designPattern.path(),
      prefixNameReplaceFile: designPattern.nameDesignPattern(),
    );

    return true;
  }

  static String _replaceWordsInFile(String file) {
    return ReservedWords.replaceWordsInFile(
      fileString: file,
    );
  }
}