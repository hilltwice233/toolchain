import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';
import 'package:toolchain_anno/annotations.dart';

import 'copy.dart';

class StateDataGenerator extends GeneratorForAnnotation<StateData> {
  @override
  String generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    final options = const StateData().updateFrom(annotation);
    final names = StateDataNames(element.displayName);

    return '''
      part of '${buildStep.inputId.pathSegments.last}';

      ${options.copy ? generateCopyWith(element) : ''}
      ${options.stateless ? generateStateless(names) : ''}
    ''';
  }
}

extension ParseStateData on StateData {
  StateData updateFrom(ConstantReader annotation) {
    final copy = annotation.peek('copy')?.boolValue ?? this.copy;
    final stateful = annotation.peek('stateful')?.boolValue ?? this.stateful;
    final stateless = annotation.peek('stateless')?.boolValue ?? this.stateless;

    return StateData(
      copy: copy | stateful,
      stateful: stateful,
      stateless: stateless | stateful,
    );
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

String generateStateless(StateDataNames names) {
  return '''
    class ${names.bare} extends StatelessWidget {
      const ${names.bare}({
        required this.child,
        required this.data,
        super.key,
      });

      final ${names.data} data;
      final Widget child;

      ${names.data}? maybeOf(BuildContext context) => context
          .dependOnInheritedWidgetOfExactType<${names.inherit}>()
          ?.data;

      ${names.data} of(BuildContext context) {
        final data = maybeOf(context);
        assert(data != null, 'cannot find ${names.bare} in context');
        return data!;
      }

      @override
      Widget build(BuildContext context) {
        return ${names.inherit}(
          data: data,
          child: child,
        );
      }
    }

    ${generateInherit(names)}
  ''';
}
