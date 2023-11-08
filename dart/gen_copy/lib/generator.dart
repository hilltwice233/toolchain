import 'package:analyzer/dart/element/element.dart';

String generateCopyWith(Element element) {
  final className = element.displayName;

  return '''
    extension Copy$className on $className {}
  ''';
}
