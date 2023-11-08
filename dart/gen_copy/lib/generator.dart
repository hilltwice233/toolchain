import 'package:analyzer/dart/element/element.dart';

String generateCopyWith(Element element) {
  final className = element.displayName;

  final input = StringBuffer();
  final output = StringBuffer();

  return '''
    extension Copy$className on $className {
      $className copyWith(${input.isEmpty ? '' : input}) {
        return ${output.isEmpty ? 'const' : ''} $className($output);
      }
    }
  ''';
}
