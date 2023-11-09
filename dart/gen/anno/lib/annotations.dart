class Copy {
  /// Annotation for generate `copyWith` method.
  const Copy();
}

class StateData {
  /// Annotation for generate methods for state data management.
  const StateData({
    this.copy = false,
  });

  final bool copy;
}
