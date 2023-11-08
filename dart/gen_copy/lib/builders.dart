import 'package:build/build.dart';
import 'package:gen_copy/copy_generator.dart';
import 'package:source_gen/source_gen.dart';

Builder copyBuilder(BuilderOptions options) {
  return LibraryBuilder(
    CopyGenerator(),
    generatedExtension: '.copy.g.dart',
  );
}
