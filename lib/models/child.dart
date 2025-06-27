import 'package:kids_clouds/models/event.dart';

class Child {
  final String id;
  final String name;
  final String imageUrl;
  final List<Event> events;

  Child({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.events,
  });
}
