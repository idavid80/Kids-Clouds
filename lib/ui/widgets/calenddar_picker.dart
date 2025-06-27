import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:kids_clouds/core/theme.dart'; // Importa tu AppTheme para utilidades responsivas

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
    _tempRange = widget.initialRange ??
        DateTimeRange(start: DateTime.now(), end: DateTime.now());
    _focusedDay = _tempRange.start;
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
  'Selecciona rango de fechas',
  style: textTheme.titleLarge,
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
            final normalizedDay = DateTime.utc(day.year, day.month, day.day);
            final normalizedStart = DateTime.utc(_tempRange.start.year, _tempRange.start.month, _tempRange.start.day);
            final normalizedEnd = DateTime.utc(_tempRange.end.year, _tempRange.end.month, _tempRange.end.day);

            return (normalizedDay.isAtSameMomentAs(normalizedStart) ||
                normalizedDay.isAtSameMomentAs(normalizedEnd) ||
                (normalizedDay.isAfter(normalizedStart) && normalizedDay.isBefore(normalizedEnd)));
          },
          onDaySelected: (selectedDay, focusedDay) {
            setState(() {
              final normalizedSelectedDay = DateTime.utc(selectedDay.year, selectedDay.month, selectedDay.day);

              if (_tempRange.start.day == _tempRange.end.day &&
                  _tempRange.start.month == _tempRange.end.month &&
                  _tempRange.start.year == _tempRange.end.year) {
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
            'Cancelar',
            style: textTheme.labelLarge!.copyWith(color: colorScheme.primary),
          ),
        ),
        TextButton(
          onPressed: () {
            widget.onRangeSelected(_tempRange);
            Navigator.of(context).pop();
          },
          child: Text(
            'Aceptar',
            style: textTheme.labelLarge!.copyWith(color: colorScheme.primary),
          ),
        ),
      ],
    );
  }
}
