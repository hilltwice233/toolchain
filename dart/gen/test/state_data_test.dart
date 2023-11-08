import 'package:test/test.dart';
import 'package:toolchain_gen/src/state_data.dart';

void main() => testStateDate();

void testStateDate() {
  group('state data names', () {
    test('normal', () {
      final names = StateDataNames('ExampleData');
      expect(names.bare, 'Example');
      expect(names.data, 'ExampleData');
      expect(names.inherit, '_InheritedExample');
    });
  });
}
