import 'package:analyzer/dart/element/element.dart';

const ignorePosBoolLint = '// ignore: avoid_positional_boolean_parameters';

String generateCopyWith(Element element) {
  final className = element.displayName;

  final input = StringBuffer();
  final output = StringBuffer();

  for (final child in element.children) {
    if (child.kind == ElementKind.FIELD && child.isPublic) {
      final field = child as FieldElement;
      final name = field.displayName;
      final type = field.type.toString();

      if (type == 'bool') input.writeln('    $ignorePosBoolLint');
      input.writeln('$type? $name,');
      output.writeln('$name: $name ?? this.$name,');
    }
  }

  return '''
    extension Copy$className on $className {
      $className copyWith(${input.isEmpty ? '' : input}) {
        return ${output.isEmpty ? 'const' : ''} $className($output);
      }
    }
  ''';
}
