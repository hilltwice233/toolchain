import 'package:toolchain_anno/annotations.dart';

part 'copy.copy.g.dart';

@Copy()
class ExampleCopy {
  const ExampleCopy({
    this.name = 'hilltwice',
    this.age = 22,
    this.hasYChromosome = true,
  });

  final String name;
  final int age;
  final bool hasYChromosome;
}
