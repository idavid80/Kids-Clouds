import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart'; // Needed for IconData
import 'package:kids_clouds/models/event.dart'; // Import your EventCategory enum

void main() {
  group('EventCategory', () {
    // Test case 1: Verify properties for EventCategory.alimentacion
    test('alimentacion category has correct label and icon', () {
      const category = EventCategory.alimentacion;
      expect(category.label, 'Alimentación');
      expect(category.icon, Icons.restaurant);
    });

    // Test case 2: Verify properties for EventCategory.siesta
    test('siesta category has correct label and icon', () {
      const category = EventCategory.siesta;
      expect(category.label, 'Siesta');
      expect(category.icon, Icons.bedtime);
    });

    // Test case 3: Verify properties for EventCategory.actividades
    test('actividades category has correct label and icon', () {
      const category = EventCategory.actividades;
      expect(category.label, 'Actividad');
      expect(category.icon, Icons.sports_soccer);
    });

    // Test case 4: Verify properties for EventCategory.deposiciones
    test('deposiciones category has correct label and icon', () {
      const category = EventCategory.deposiciones;
      expect(category.label, 'Deposición');
      expect(category.icon, Icons.baby_changing_station);
    });

    // Test case 5: Verify properties for EventCategory.observaciones
    test('observaciones category has correct label and icon', () {
      const category = EventCategory.observaciones;
      expect(category.label, 'Observación');
      expect(category.icon, Icons.visibility);
    });

    // Optional: Test to ensure all enum values are covered
    test('all EventCategory values have defined labels and icons', () {
      for (var category in EventCategory.values) {
        expect(category.label, isNotNull);
        expect(category.label, isNotEmpty);
        expect(category.icon, isNotNull);
      }
    });
  });

  // You could also add basic unit tests for the Event class itself,
  // although it's primarily a data model and its logic is minimal (constructor).
  group('Event Model', () {
    test('Event can be created with required fields and default description', () {
      final now = DateTime.now();
      final event = Event(
        id: '123',
        category: EventCategory.alimentacion,
        title: 'Desayuno',
        date: now,
      );

      expect(event.id, '123');
      expect(event.category, EventCategory.alimentacion);
      expect(event.title, 'Desayuno');
      expect(event.date, now);
      expect(event.description, ''); // Verify default value
    });

    test('Event can be created with custom description', () {
      final now = DateTime.now();
      final event = Event(
        id: '456',
        category: EventCategory.observaciones,
        title: 'Nota importante',
        date: now,
        description: 'El niño se encuentra bien.',
      );

      expect(event.description, 'El niño se encuentra bien.');
    });
  });
}