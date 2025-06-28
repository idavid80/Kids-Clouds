import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:kids_clouds/core/theme.dart';

class DateRangePickerPopup extends StatefulWidget {
  final DateTimeRange? initialRange;
  final ValueChanged<DateTimeRange> onRangeSelected;

  const DateRangePickerPopup({
    super.key,
    required this.initialRange,
    required this.onRangeSelected,
  });

  @override
  State<DateRangePickerPopup> createState() => _DateRangePickerPopupState();
}

class _DateRangePickerPopupState extends State<DateRangePickerPopup> {
  late DateTimeRange _tempRange;
  late DateTime _focusedDay;

  @override
  void initState() {
    super.initState();
    _tempRange = widget.initialRange != null
        ? DateTimeRange(
            start: DateTime.utc(widget.initialRange!.start.year, widget.initialRange!.start.month, widget.initialRange!.start.day),
            end: DateTime.utc(widget.initialRange!.end.year, widget.initialRange!.end.month, widget.initialRange!.end.day),
          )
        : DateTimeRange(start: _normalizeDate(DateTime.now()), end: _normalizeDate(DateTime.now()));

    _focusedDay = _tempRange.start;
  }

  DateTime _normalizeDate(DateTime date) {
    return DateTime.utc(date.year, date.month, date.day);
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final double calendarWidth = AppTheme.responsiveSize(context, 300, 400);
    final double calendarHeight = AppTheme.responsiveSize(context, 320, 380);

    return AlertDialog(
      backgroundColor: colorScheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppTheme.responsiveSize(context, 12, 16)),
      ),
      title: Text(
        'Select Date Range',
        style: textTheme.titleLarge!.copyWith(color: colorScheme.onSurface),
      ),
      content: SizedBox(
        width: calendarWidth,
        height: calendarHeight,
        child: TableCalendar(
          firstDay: DateTime.utc(DateTime.now().year - 5, 1, 1),
          lastDay: DateTime.utc(DateTime.now().year + 5, 12, 31),
          focusedDay: _focusedDay,
          calendarFormat: CalendarFormat.month,

          selectedDayPredicate: (day) {
            final normalizedDay = _normalizeDate(day);
            return (normalizedDay.isAtSameMomentAs(_tempRange.start) ||
                normalizedDay.isAtSameMomentAs(_tempRange.end) ||
                (normalizedDay.isAfter(_tempRange.start) && normalizedDay.isBefore(_tempRange.end)));
          },

          onDaySelected: (selectedDay, focusedDay) {
            setState(() {
              final normalizedSelectedDay = _normalizeDate(selectedDay);

              if (_tempRange.start.isAtSameMomentAs(_tempRange.end)) {
                if (normalizedSelectedDay.isBefore(_tempRange.start)) {
                  _tempRange = DateTimeRange(start: normalizedSelectedDay, end: _tempRange.start);
                } else if (normalizedSelectedDay.isAfter(_tempRange.start)) {
                  _tempRange = DateTimeRange(start: _tempRange.start, end: normalizedSelectedDay);
                } else {
                  _tempRange = DateTimeRange(start: normalizedSelectedDay, end: normalizedSelectedDay);
                }
              } else {
                _tempRange = DateTimeRange(start: normalizedSelectedDay, end: normalizedSelectedDay);
              }
              _focusedDay = focusedDay;
            });
          },
          onPageChanged: (focusedDay) {
            _focusedDay = focusedDay;
          },
          calendarStyle: CalendarStyle(
            selectedDecoration: BoxDecoration(
              color: colorScheme.primary,
              shape: BoxShape.circle,
            ),
            rangeStartDecoration: BoxDecoration(
              color: colorScheme.primary,
              shape: BoxShape.circle,
            ),
            rangeEndDecoration: BoxDecoration(
              color: colorScheme.primary,
              shape: BoxShape.circle,
            ),
            todayDecoration: BoxDecoration(
              color: colorScheme.primary.withAlpha((255 * 0.3).round()),
              shape: BoxShape.circle,
            ),
            rangeHighlightColor: colorScheme.primary.withAlpha((255 * 0.1).round()),
            weekendTextStyle: TextStyle(color: colorScheme.error.withAlpha((255 * 0.7).round())),
            defaultTextStyle: TextStyle(color: colorScheme.onSurface),
            outsideTextStyle: TextStyle(color: colorScheme.onSurface.withAlpha((255 * 0.4).round())),
          ),
          headerStyle: HeaderStyle(
            formatButtonVisible: false,
            titleCentered: true,
            titleTextStyle: textTheme.titleMedium!.copyWith(color: colorScheme.onSurface),
            leftChevronIcon: Icon(Icons.chevron_left, color: colorScheme.onSurface),
            rightChevronIcon: Icon(Icons.chevron_right, color: colorScheme.onSurface),
          ),
          daysOfWeekStyle: DaysOfWeekStyle(
            weekdayStyle: TextStyle(color: colorScheme.onSurface),
            weekendStyle: TextStyle(color: colorScheme.error.withAlpha((255 * 0.7).round())),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(
            'Cancel',
            style: textTheme.labelLarge!.copyWith(color: colorScheme.primary),
          ),
        ),
        TextButton(
          onPressed: () {
            final finalRange = _tempRange.start.isAfter(_tempRange.end)
                ? DateTimeRange(start: _tempRange.end, end: _tempRange.start)
                : _tempRange;
            widget.onRangeSelected(finalRange);
            Navigator.of(context).pop();
          },
          child: Text(
            'Accept',
            style: textTheme.labelLarge!.copyWith(color: colorScheme.primary),
          ),
        ),
      ],
    );
  }
}