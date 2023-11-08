import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';
import 'package:toolchain_anno/annotations.dart';

class StateDataGenerator extends GeneratorForAnnotation<StateData> {
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
