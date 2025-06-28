import 'package:flutter/material.dart';

enum EventCategory {
  alimentacion(label: 'Alimentación', icon: Icons.restaurant),
  siesta(label: 'Siesta', icon: Icons.bedtime),
  actividades(label: 'Actividad', icon: Icons.sports_soccer),
  deposiciones(label: 'Deposición', icon: Icons.baby_changing_station),
  observaciones(label: 'Observación', icon: Icons.visibility);

  const EventCategory({required this.label, required this.icon});

  final String label;
  final IconData icon;
}

class Event {
  final String id;
  final EventCategory category;
  final String title;
  final DateTime date;
  final String description;

  Event({
    required this.id,
    required this.category,
    required this.title,
    required this.date,
    this.description = '',
  });
}
