// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// CopyGenerator
// **************************************************************************

part of 'example.dart';

extension CopyExample on Example {
  Example copyWith(
    String? name,
    int? age,
    // ignore: avoid_positional_boolean_parameters
    bool? hasYChromosome,
  ) {
    return Example(
      name: name ?? this.name,
      age: age ?? this.age,
      hasYChromosome: hasYChromosome ?? this.hasYChromosome,
    );
  }
}
