import 'package:flutter/material.dart';
import 'package:kids_clouds/models/event.dart';
import 'package:kids_clouds/ui/responsive/layout_helper.dart';
import 'package:kids_clouds/ui/widgets/category_menu.dart';
import 'package:kids_clouds/ui/widgets/event_card.dart';
import '../../data/mock_data.dart';
import '../widgets/header.dart';

// --- NEW KEYS FOR TESTING ---
const Key selectDateRangeButtonKey = Key('selectDateRangeButton');
const Key clearDateRangeButtonKey = Key('clearDateRangeButton');
// Keys for child cards in the ListView.Builder
Key childCardKey(String childId) => Key('childCard_$childId');
Key noEventsMessageKey(String childId) => Key('noEventsMessage_$childId');


class AgendaScreenContent extends StatefulWidget {
  const AgendaScreenContent({super.key});

  @override
  State<AgendaScreenContent> createState() => _AgendaScreenContentState();
}

class _AgendaScreenContentState extends State<AgendaScreenContent> {
  String? selectedChildId;
  EventCategory? selectedCategory;
  DateTimeRange? selectedDateRange;

  void _onChildSelected(String? childId) {
    setState(() {
      selectedChildId = childId;
    });
  }

  void _onCategorySelected(EventCategory? category) {
    setState(() {
      selectedCategory = category;
    });
  }

  Future<void> _selectDateRange() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year, now.month, now.day - 7); // 7 days before today
    final lastDate = DateTime(now.year, now.month, now.day + 7);  // 7 days after today

    final picked = await showDateRangePicker(
      context: context,
      firstDate: firstDate,
      lastDate: lastDate,
      initialDateRange: selectedDateRange ??
          DateTimeRange(start: now.subtract(const Duration(days: 0)), end: now), // Default to today
      builder: (context, child) { // Added builder for consistent theme in picker
        return Theme(
          data: ThemeData.light(), // Or use your app's theme
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        selectedDateRange = picked;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    final isDesktop = LayoutHelper.isDesktop(context);

    final filteredChildren = selectedChildId == null
        ? MockData.children
        : MockData.children.where((child) => child.id == selectedChildId).toList();

    // filter events by selected category and date range
    bool eventInRange(Event event) {
      if (selectedDateRange == null) return true;
      // Normalize dates to just year, month, day for comparison, ignoring time
      final eventDateNormalized = DateTime(event.date.year, event.date.month, event.date.day);
      final startDateNormalized = DateTime(selectedDateRange!.start.year, selectedDateRange!.start.month, selectedDateRange!.start.day);
      final endDateNormalized = DateTime(selectedDateRange!.end.year, selectedDateRange!.end.month, selectedDateRange!.end.day);

      return !eventDateNormalized.isBefore(startDateNormalized) &&
             !eventDateNormalized.isAfter(endDateNormalized);
    }

    return Padding(
      padding: EdgeInsets.all(isDesktop ? 32.0 : 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Header(
            children: MockData.children,
            selectedChildId: selectedChildId,
            onChildSelected: _onChildSelected,
          ),
          const SizedBox(height: 12),
          CategoryMenu(
            selectedCategory: selectedCategory,
            onCategorySelected: _onCategorySelected,
          ),
          const SizedBox(height: 12),

          Row(
            children: [
              const Icon(Icons.calendar_today),
              const SizedBox(width: 8),
              TextButton(
                key: selectDateRangeButtonKey, // Add key here
                onPressed: _selectDateRange,
                child: Text(
                  selectedDateRange == null
                      ? 'Seleccionar rango de fechas'
                      : '${selectedDateRange!.start.toLocal().toShortDateString()} - ${selectedDateRange!.end.toLocal().toShortDateString()}',
                  style: const TextStyle(fontSize: 16),
                ),
              ),
              if (selectedDateRange != null)
                IconButton(
                  key: clearDateRangeButtonKey, // Add key here
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    setState(() {
                      selectedDateRange = null;
                    });
                  },
                ),
            ],
          ),

          const SizedBox(height: 16),
          Text(
            'Eventos:',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 8),

          Expanded(
            child: ListView.builder(
              itemCount: filteredChildren.length,
              itemBuilder: (context, index) {
                final child = filteredChildren[index];
                final filteredEvents = child.events.where((event) {
                  final matchesCategory = selectedCategory == null || event.category == selectedCategory;
                  final matchesDate = eventInRange(event);
                  return matchesCategory && matchesDate;
                }).toList();

                return Card(
                  key: childCardKey(child.id), // Add key here
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              backgroundImage: NetworkImage(child.imageUrl),
                            ),
                            const SizedBox(width: 12),
                            Text(
                              child.name,
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        if (filteredEvents.isEmpty)
                          Text(
                            key: noEventsMessageKey(child.id), // Add key here
                            'Sin eventos para esta categoría y fechas',
                            style: TextStyle(color: Theme.of(context).colorScheme.onSurface.withAlpha((255 * 0.6).round())),
                          )
                        else
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: filteredEvents.length,
                            itemBuilder: (context, eventIndex) {
                              final event = filteredEvents[eventIndex];
                              // Assuming EventCard does not need a specific key for this test
                              return EventCard(event: event, child: child);
                            },
                          ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

extension DateHelpers on DateTime {
  String toShortDateString() {
    return '${day.toString().padLeft(2, '0')}/'
           '${month.toString().padLeft(2, '0')}/'
           '$year';
  }
}