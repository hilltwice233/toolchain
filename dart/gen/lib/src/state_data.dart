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
    return '''
      part of '${buildStep.inputId.pathSegments.last}';

      ${options.stateless ? generateStateless(element) : ''}
      ${options.stateful ? generateStateful(element) : ''}
      ${options.copy ? generateCopyWith(element) : ''}
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

class StateDataHandlerNames extends StateDataNames {
  StateDataHandlerNames(super.raw) {
    handler = '${bare}Handler';
    handlerState = '_${handler}State';
    handlerInherit = '_Inherited$handler';
  }

  late final String handler;
  late final String handlerState;
  late final String handlerInherit;
}

String generateStateless(Element element) {
  final names = StateDataNames(element.displayName);
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

String generateStateful(Element element) {
  final names = StateDataHandlerNames(element.displayName);
  final input = StringBuffer();
  final output = StringBuffer();

  for (final child in element.children) {
    if (child.kind == ElementKind.FIELD) {
      final field = child as FieldElement;
      final name = field.name;
      final type = field.type.toString();

      input.writeln('$type? $name,');
      output.writeln('$name: $name,');
    }
  }

  return '''
    class ${names.handler} extends StatefulWidget {
      const ${names.handler}({
        required this.child,
        super.key,
        this.didUpdate = const {},
        this.initData = const ${names.data}(),
      });

      final Set<void Function(${names.data} data)> didUpdate;
      final ${names.data} initData;
      final Widget child;

      ${names.handlerState}? _maybeStateOf(BuildContext context) => context
          .dependOnInheritedWidgetOfExactType<${names.handlerInherit}>()
          ?.state;

      void maybeUpdateFrom(BuildContext context, ${names.data} data) {
        final state = _maybeStateOf(context);
        if (state == null) return;
        if (data != state.data) state.data = data;
      }

      void maybeUpdate(
        BuildContext context${input.isEmpty ? '' : ', {$input}'}
      ) {
        final state = _maybeStateOf(context);
        if (state == null) return;
        state.data = state.data.copyWith($output);
      }

      ${names.handlerState} _stateOf(BuildContext context) {
        final state = _maybeStateOf(context);
        assert(state != null, 'cannot find ${names.handler} in context');
        return state!;
      }

      void updateFrom(BuildContext context, ${names.data} data) {
        final state = _stateOf(context);
        if (data != state.data) state.data = data;
      }

      void update(BuildContext context${input.isEmpty ? '' : ', {$input}'}) {
        final state = _stateOf(context);
        state.data = state.data.copyWith($output);
      }

      @override
      State<${names.handler}> createState() => ${names.handlerState}();
    }

    class ${names.handlerState} extends State<${names.handler}> {
      late ${names.data} _data = widget.initData;

      ${names.data} get data => _data;
      set data(${names.data} value) {
        if (data != value) setState(() => _data = value);
      }

      @override
      Widget build(BuildContext context) {
        return ${names.handlerInherit}(
          state: this,
          child: ${names.bare}(
            data: data,
            child: widget.child,
          ),
        );
      }
    }

    class ${names.handlerInherit} extends InheritedWidget {
      const ${names.handlerInherit}({
        required this.state,
        required super.child,
      });

      final ${names.handlerState} state;

      @override
      bool updateShouldNotify(covariant ${names.handlerInherit} old) {
        return false;
      }
    }
  ''';
}
