import 'dart:io';

import 'package:path/path.dart' as p;

String normalize(String path) {
  path = p.normalize(path);
  path = path.replaceAll('/', Platform.pathSeparator);
  path = path.replaceAll('\\', Platform.pathSeparator);
  
  return path;
}
