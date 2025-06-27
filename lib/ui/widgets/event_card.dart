import 'package:flutter/material.dart';
import 'package:kids_clouds/models/child.dart';
import 'package:kids_clouds/models/event.dart';

class EventCard extends StatelessWidget {
  final Event event;
  final Child child;

  const EventCard({
    super.key,
    required this.event,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final Color shadowColor = Theme.of(context).brightness == Brightness.light
        ? Colors.black.withAlpha((255 * 0.08).round())
        : Colors.black.withAlpha((255 * 0.2).round());

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: shadowColor,
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            event.category.icon,
            color: Theme.of(context).colorScheme.onSurface,
            size: 28,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  event.category.label,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 4),
                if (event.description.isNotEmpty) ...[
                  const SizedBox(height: 4),
                  Text(
                    event.description,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onSurface.withAlpha((255 * 0.7).round()),
                    ),
                  ),
                ],
                const SizedBox(height: 4),
                Text(
                  '${event.date.day}/${event.date.month}/${event.date.year} - ${TimeOfDay.fromDateTime(event.date).format(context)}',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSurface.withAlpha((255 * 0.5).round()),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
