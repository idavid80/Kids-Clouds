import 'dart:math';

import 'package:kids_clouds/models/child.dart';
import 'package:kids_clouds/models/event.dart';
import 'package:kids_clouds/models/parant.dart';

class MockData {
  static Parent? parent;
  static List<Child> children = [];
  static int _eventIdCounter = 0;

  // Make Random injectable for testing purposes
  // By default, it uses a real Random instance.
  // For tests, we can provide a mock one.
  static Random _random = Random();

  static void setRandom(Random random) {
    _random = random;
  }

  static void initialize() {
    // Reset state before initialization for consistent tests
    parent = null;
    children = [];
    _eventIdCounter = 0;

    parent = Parent(
      id: 'parent_1',
      name: 'Luis López',
      avatarUrl: 'https://randomuser.me/api/portraits/men/41.jpg',
    );

    children = [
      Child(
        id: 'child_1',
        name: 'Lucas',
        imageUrl: 'https://randomuser.me/api/portraits/lego/1.jpg',
        age: 3,
        parentId: parent!.id,
        events: [],
      ),
      Child(
        id: 'child_2',
        name: 'Lucas',
        imageUrl: 'https://randomuser.me/api/portraits/lego/2.jpg',
        age: 2,
        parentId: parent!.id,
        events: [],
      ),
      Child(
        id: 'child_3',
        name: 'Sofía',
        imageUrl: 'https://randomuser.me/api/portraits/lego/3.jpg',
        age: 4,
        parentId: parent!.id,
        events: [],
      ),
      Child(
        id: 'child_4',
        name: 'Diego',
        imageUrl: 'https://randomuser.me/api/portraits/lego/4.jpg',
        age: 1,
        parentId: parent!.id,
        events: [],
      ),
    ];

    _generateEventsForChildren(); // Generate random events for each child
  }

  static void _generateEventsForChildren() {
    final now = DateTime.now(); // Date part will be fixed to now for all events

    for (var child in children) {
      child.events.clear();

      // Number of events: _random.nextInt(4) + 2 => 2 to 5 events
      for (int i = 0; i < (_random.nextInt(4) + 2); i++) {
        final selectedCategory = EventCategory.values[_random.nextInt(EventCategory.values.length)];
        final hour = _random.nextInt(24);
        final minute = _random.nextInt(60);
        // Normalize date to current day for consistent testing of event properties,
        // but still use random hour/minute for variety.
        final eventDate = DateTime(now.year, now.month, now.day, hour, minute);


        String description;
        String title;

        switch (selectedCategory) {
          case EventCategory.alimentacion:
            title = 'Comida';
            description = _random.nextBool()
                ? 'Leche materna (${_random.nextInt(100) + 50}ml)'
                : 'Papilla de frutas';
            break;
          case EventCategory.siesta:
            title = 'Siesta';
            description = _random.nextBool()
                ? 'Siesta de ${_random.nextInt(2) + 1} hora(s)'
                : 'Siesta corta';
            break;
          case EventCategory.actividades:
            title = 'Actividad';
            description = _random.nextBool()
                ? 'Juego en el parque'
                : 'Clase de estimulación temprana';
            break;
          case EventCategory.deposiciones:
            title = 'Cambio de pañal';
            description = _random.nextBool()
                ? 'Pañal mojado'
                : 'Pañal sucio';
            break;
          case EventCategory.observaciones:
            title = 'Observación';
            description = _random.nextBool()
                ? 'Un poco irritable hoy'
                : 'Muy activo y feliz';
            break;
        }

        child.events.add(
          Event(
            id: 'event_${_eventIdCounter++}',
            category: selectedCategory,
            title: title,
            date: eventDate,
            description: description,
          ),
        );
      }
      // Order events by date
      child.events.sort((a, b) => a.date.compareTo(b.date));
    }
  }
}

// Function to initialize mock data - this remains the same for external use
void initializeMockData() {
  MockData.initialize();
}