import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:gen_copy_anno/annotations.dart';
import 'package:source_gen/source_gen.dart';

class CopyGenerator extends GeneratorForAnnotation<Copy> {
  @override
  String generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    return '''
      part of '${buildStep.inputId.pathSegments.last}';
    ''';
  }
}
