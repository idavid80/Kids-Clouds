import 'dart:math';
import 'package:flutter_test/flutter_test.dart';
import 'package:kids_clouds/data/mock_data.dart';

// A mock implementation of Random that returns predictable values
class MockRandom implements Random {
  final List<int> nextIntValues;
  final List<bool> nextBoolValues;
  int _nextIntIndex = 0;
  int _nextBoolIndex = 0;

  MockRandom({
    this.nextIntValues = const [],
    this.nextBoolValues = const [],
  });

  @override
  int nextInt(int max) {
    if (_nextIntIndex >= nextIntValues.length) {
      fail('MockRandom.nextInt called more times than expected or without enough values.');
    }
    return nextIntValues[_nextIntIndex++];
  }

  @override
  bool nextBool() {
    if (_nextBoolIndex >= nextBoolValues.length) {
      fail('MockRandom.nextBool called more times than expected or without enough values.');
    }
    return nextBoolValues[_nextBoolIndex++];
  }

  // Not used in MockData, but required by the interface
  @override
  double nextDouble() => throw UnimplementedError();
}


void main() {
  group('MockData', () {
    // This runs before each test to reset the MockData state
    setUp(() {
      MockData.parent = null;
      MockData.children = [];
      // Reset _eventIdCounter (it's private, but we can manage its effect by re-initializing)
      // Or if you want to be super clean, make _eventIdCounter accessible for testing
      // For now, re-initialize should reset its effect.
      // Resetting the random instance to the default one for tests that don't need mocking.
      MockData.setRandom(Random());
    });

    test('initialize populates parent and children lists', () {
      MockData.initialize();

      expect(MockData.parent, isNotNull);
      expect(MockData.parent!.id, 'parent_1');
      expect(MockData.parent!.name, 'Luis López');

      expect(MockData.children, isNotNull);
      expect(MockData.children.length, 4); // Check the number of children
      expect(MockData.children[0].name, 'Lucas');
      expect(MockData.children[3].name, 'Diego');
    });

    test('children have unique IDs', () {
      MockData.initialize();

      final childIds = MockData.children.map((child) => child.id).toSet();
      expect(childIds.length, MockData.children.length, reason: 'Child IDs should be unique');
    });

    test('initializeMockData calls MockData.initialize', () {
      MockData.parent = null; // Ensure initial state is clear
      MockData.children = [];

      initializeMockData(); // Call the global function

      expect(MockData.parent, isNotNull);
      expect(MockData.children.isNotEmpty, isTrue);
    });
  });
}