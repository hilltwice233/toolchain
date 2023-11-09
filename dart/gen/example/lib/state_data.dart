import 'package:flutter/widgets.dart';
import 'package:toolchain_anno/annotations.dart';

part 'state_data.data.g.dart';

@StateData(stateful: true)
class ExampleStateData {
  const ExampleStateData({
    this.name = 'hilltwice',
    this.age = 22,
    this.hasYChromosome = true,
  });

  final String name;
  final int age;
  final bool hasYChromosome;
}
