import 'package:flutter/material.dart';
import 'package:kids_clouds/models/event.dart';
import 'package:kids_clouds/core/theme.dart';

class CategoryMenu extends StatelessWidget {
  final EventCategory? selectedCategory; // Currently selected category, nullable to allow "All"
  final Function(EventCategory?) onCategorySelected; // Callback when a category is selected

  const CategoryMenu({
    super.key,
    required this.selectedCategory,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    final categories = EventCategory.values; // All available categories
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    // Responsive font size for the chip labels
    final double chipTextFontSize = AppTheme.responsiveSize(context, 14, 16);

    return Padding(
      padding: AppTheme.responsivePadding(context),
      child: Wrap(
        spacing: 8.0,
        runSpacing: 8.0,
        alignment: WrapAlignment.start,
        children: [
          // "All" category chip to reset the selection
          ChoiceChip(
            label: Text(
              'Todos',
              style: textTheme.bodyMedium?.copyWith(
                fontSize: chipTextFontSize,
                color: selectedCategory == null
                    ? colorScheme.onPrimary
                    : colorScheme.onSurface,
              ),
            ),
            selected: selectedCategory == null, // Selected when no specific category is chosen
            onSelected: (_) => onCategorySelected(null), // Clear selection on tap
            selectedColor: colorScheme.primary,
            backgroundColor: colorScheme.surfaceContainerHighest,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side: BorderSide(
                color: selectedCategory == null
                    ? Colors.transparent
                    : colorScheme.outline.withAlpha((255 * 0.5).round()),
              ),
            ),
            labelPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          ),

          // Dynamic category chips from the enum values
          ...categories.map((category) {
            final bool isSelected = selectedCategory == category;
            return ChoiceChip(
              label: Text(
                category.label,
                style: textTheme.bodyMedium?.copyWith(
                  fontSize: chipTextFontSize,
                  color: isSelected
                      ? colorScheme.onPrimary
                      : colorScheme.onSurface,
                ),
              ),
              selected: isSelected, // Whether this chip is selected
              onSelected: (_) => onCategorySelected(category), // Callback with selected category
              selectedColor: colorScheme.primary,
              backgroundColor: colorScheme.surfaceContainerHighest,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
                side: BorderSide(
                  color: isSelected
                      ? Colors.transparent
                      : colorScheme.outline.withAlpha((255 * 0.5).round()),
                ),
              ),
              labelPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            );
          }),
        ],
      ),
    );
  }
}
