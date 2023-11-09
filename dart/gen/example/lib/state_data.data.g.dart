// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StateDataGenerator
// **************************************************************************

part of 'state_data.dart';

class ExampleState extends StatelessWidget {
  const ExampleState({
    required this.child,
    required this.data,
    super.key,
  });

  final ExampleStateData data;
  final Widget child;

  ExampleStateData? maybeOf(BuildContext context) => context
      .dependOnInheritedWidgetOfExactType<_InheritedExampleState>()
      ?.data;

  ExampleStateData of(BuildContext context) {
    final data = maybeOf(context);
    assert(data != null, 'cannot find ExampleState in context');
    return data!;
  }

  @override
  Widget build(BuildContext context) {
    return _InheritedExampleState(
      data: data,
      child: child,
    );
  }
}

class _InheritedExampleState extends InheritedWidget {
  const _InheritedExampleState({
    required this.data,
    required super.child,
  });

  final ExampleStateData data;

  @override
  bool updateShouldNotify(covariant _InheritedExampleState old) {
    return data != old.data;
  }
}

class ExampleStateHandler extends StatefulWidget {
  const ExampleStateHandler({
    required this.child,
    super.key,
    this.onUpdate = const {},
    this.initData = const ExampleStateData(),
  });

  final Set<void Function(ExampleStateData data)> onUpdate;
  final ExampleStateData initData;
  final Widget child;

  _ExampleStateHandlerState? _maybeStateOf(BuildContext context) => context
      .dependOnInheritedWidgetOfExactType<_InheritedExampleStateHandler>()
      ?.state;

  Set<void Function(ExampleStateData data)>? maybeOnUpdateOf(
    BuildContext context,
  ) =>
      _maybeStateOf(context)?.onUpdate;

  void maybeUpdateFrom(BuildContext context, ExampleStateData data) {
    final state = _maybeStateOf(context);
    if (state == null) return;
    if (data != state.data) state.data = data;
  }

  void maybeUpdate(
    BuildContext context, {
    String? name,
    int? age,
    bool? hasYChromosome,
  }) {
    final state = _maybeStateOf(context);
    if (state == null) return;
    state.data = state.data.copyWith(
      name: name,
      age: age,
      hasYChromosome: hasYChromosome,
    );
  }

  _ExampleStateHandlerState _stateOf(BuildContext context) {
    final state = _maybeStateOf(context);
    assert(state != null, 'cannot find ExampleStateHandler in context');
    return state!;
  }

  Set<void Function(ExampleStateData data)> onUpdateOf(
    BuildContext context,
  ) =>
      _stateOf(context).onUpdate;

  void updateFrom(BuildContext context, ExampleStateData data) {
    final state = _stateOf(context);
    if (data != state.data) state.data = data;
  }

  void update(
    BuildContext context, {
    String? name,
    int? age,
    bool? hasYChromosome,
  }) {
    final state = _stateOf(context);
    state.data = state.data.copyWith(
      name: name,
      age: age,
      hasYChromosome: hasYChromosome,
    );
  }

  @override
  State<ExampleStateHandler> createState() => _ExampleStateHandlerState();
}

class _ExampleStateHandlerState extends State<ExampleStateHandler> {
  late final _onUpdate = widget.onUpdate;
  Set<void Function(ExampleStateData data)> get onUpdate => _onUpdate;

  late ExampleStateData _data = widget.initData;
  ExampleStateData get data => _data;
  set data(ExampleStateData value) {
    if (data != value) {
      setState(() => _data = value);
      for (final action in onUpdate) {
        action.call(data);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return _InheritedExampleStateHandler(
      state: this,
      child: ExampleState(
        data: data,
        child: widget.child,
      ),
    );
  }
}

class _InheritedExampleStateHandler extends InheritedWidget {
  const _InheritedExampleStateHandler({
    required this.state,
    required super.child,
  });

  final _ExampleStateHandlerState state;

  @override
  bool updateShouldNotify(covariant _InheritedExampleStateHandler old) {
    return false;
  }
}

extension CopyExampleStateData on ExampleStateData {
  ExampleStateData copyWith({
    String? name,
    int? age,
    bool? hasYChromosome,
  }) {
    return ExampleStateData(
      name: name ?? this.name,
      age: age ?? this.age,
      hasYChromosome: hasYChromosome ?? this.hasYChromosome,
    );
  }
}
