import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

import 'src/copy.dart';
import 'src/state_data.dart';

Builder copyBuilder(BuilderOptions options) {
  return LibraryBuilder(
    CopyGenerator(),
    generatedExtension: '.copy.g.dart',
  );
}

Builder stateDataBuilder(BuilderOptions options) {
  return LibraryBuilder(
    StateDataGenerator(),
    generatedExtension: '.data.g.dart',
  );
}
