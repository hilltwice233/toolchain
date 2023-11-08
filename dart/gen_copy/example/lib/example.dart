import 'package:gen_copy_anno/annotations.dart';

part 'example.copy.g.dart';

@Copy()
class Example {
  const Example({
    this.name = 'hilltwice',
    this.age = 22,
    this.hasYChromosome = true,
  });

  final String name;
  final int age;
  final bool hasYChromosome;
}
