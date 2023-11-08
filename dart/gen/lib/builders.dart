import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

import 'src/copy.dart';

Builder copyBuilder(BuilderOptions options) {
  return LibraryBuilder(
    CopyGenerator(),
    generatedExtension: '.copy.g.dart',
  );
}
