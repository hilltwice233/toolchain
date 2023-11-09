import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';
import 'package:toolchain_anno/annotations.dart';

class CopyGenerator extends GeneratorForAnnotation<Copy> {
  @override
  String generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    return '''
      part of '${buildStep.inputId.pathSegments.last}';

      ${generateCopyWith(element)}
    ''';
  }
}

String generateCopyWith(Element element) {
  final className = element.displayName;

  final input = StringBuffer();
  final output = StringBuffer();

  for (final child in element.children) {
    if (child.kind == ElementKind.FIELD && child.isPublic) {
      final field = child as FieldElement;
      final name = field.displayName;
      final type = field.type.toString();

      input.writeln('$type? $name,');
      output.writeln('$name: $name ?? this.$name,');
    }
  }

  return '''
    extension Copy$className on $className {
      $className copyWith(${input.isEmpty ? '' : '{$input}'}) {
        return ${output.isEmpty ? 'const' : ''} $className($output);
      }
    }
  ''';
}
