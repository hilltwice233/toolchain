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

class StateDataNames {
  StateDataNames(String raw) {
    if (!raw.endsWith('Data')) throw Exception('invalid state data name: $raw');
    data = raw;
    bare = raw.substring(0, raw.length - 4);
    inherit = '_Inherited$bare';
  }

  late final String bare;
  late final String data;
  late final String inherit;
}

String generateInherit(StateDataNames names) {
  return '''
    class ${names.inherit} extends InheritedWidget {
      const ${names.inherit}({
        required this.data,
        required super.child,
      });

      final ${names.data} data;

      @override
      bool updateShouldNotify(covariant ${names.inherit} old) {
        return data != old.data;
      }
    }
  ''';
}
