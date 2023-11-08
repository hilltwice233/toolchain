// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// CopyGenerator
// **************************************************************************

part of 'copy.dart';

extension CopyExampleCopy on ExampleCopy {
  ExampleCopy copyWith(
    String? name,
    int? age,
    // ignore: avoid_positional_boolean_parameters
    bool? hasYChromosome,
  ) {
    return ExampleCopy(
      name: name ?? this.name,
      age: age ?? this.age,
      hasYChromosome: hasYChromosome ?? this.hasYChromosome,
    );
  }
}
