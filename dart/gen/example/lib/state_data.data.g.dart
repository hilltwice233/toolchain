// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StateDataGenerator
// **************************************************************************

part of 'state_data.dart';

extension CopyExampleStateData on ExampleStateData {
  ExampleStateData copyWith() {
    return const ExampleStateData();
  }
}

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
