import 'package:js_cli/core/utils/reserved_words.dart';
import 'package:js_cli/models/entities/design_pattern/design_pattern.dart';

class PageDesignPattern extends DesignPattern {
  static const String _template = '''
import 'package:flutter/material.dart';
import '{{controllerNameFile.snakeCase}}.dart';

class {{pageNameClass.pascalCase}} extends StatefulWidget {

  @override
  _{{pageNameClass.pascalCase}}State createState() => _{{pageNameClass.pascalCase}}State();
}

class _{{name.pascalCase}}PageState extends State<{{pageNameClass.pascalCase}}> {
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(),
      body: Container(),
    );
  }
}
  ''';

  @override
  String nameFile() {
    return persistValue(
      'pageNameFile',
      '{{name.snakeCase}}_page',
    );
  }

  @override
  String path() {
    return persistValue(
      'pagePath',
      'presentation/ui/pages/{{name.snakeCase}}',
    );
  }

  @override
  String nameClass() {
    return persistValue(
      'pageNameClass',
      '{{name.pascalCase}}Page',
    );
  }

  @override
  String template() {
    return readTemplete(
      'template',
      'page.template',
      _template,
      ReservedWords.removeWordsInFile(
        fileString: path(),
      ),
    );
  }

  @override
  String nameDesignPattern() {
    return 'page';
  }

  @override
  String extension() {
    return persistValue(
      'pageExtension',
      'dart',
    );
  }
}
