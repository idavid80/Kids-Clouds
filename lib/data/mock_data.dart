
import 'package:kids_clouds/models/child.dart';
import 'package:kids_clouds/models/event.dart';

class MockData {
  static List<Child> children = [
    Child(
      id: 'c1',
      name: 'Lucas',
      imageUrl: 'https://randomuser.me/api/portraits/lego/1.jpg',
      events: [],
    ),
    Child(
      id: 'c2',
      name: 'Sofía',
      imageUrl: 'https://randomuser.me/api/portraits/lego/2.jpg',
      events: [],
    ),
  ];

  static List<Event> events = [
    Event(
      id: 'e1',
      childId: 'c1',
      category: EventCategory.alimentacion,
      title: 'Desayuno',
      description: 'Leche y cereales',
      date: DateTime.now().subtract(const Duration(hours: 2)),
    ),
    Event(
      id: 'e2',
      childId: 'c1',
      category: EventCategory.siesta,
      title: 'Siesta de la mañana',
      description: 'Duración 1 hora',
      date: DateTime.now().subtract(const Duration(hours: 1)),
    ),
    Event(
      id: 'e3',
      childId: 'c2',
      category: EventCategory.actividades,
      title: 'Juego con bloques',
      description: 'Construcción creativa',
      date: DateTime.now(),
    ),

    Event(
      id: 'e4',
      childId: 'c1',
      category: EventCategory.alimentacion,
      title: 'Almuerzo',
      description: 'Pasta con verduras',
      date: DateTime.now().add(const Duration(days: 1)),
    ),
    Event(
      id: 'e5',
      childId: 'c2',
      category: EventCategory.siesta,
      title: 'Siesta de la tarde',
      description: 'Duración 1 hora y media',
      date: DateTime.now().add(const Duration(days: 2)),
    ),
  ];

  static void assignEventsToChildren() {
    for (var child in children) {
      child.events.clear();
      child.events.addAll(events.where((e) => e.childId == child.id));
    }
  }
}

void initializeMockData() {
  MockData.assignEventsToChildren();
}