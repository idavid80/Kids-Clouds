import 'package:flutter/material.dart';
import 'package:kids_clouds/models/child.dart';

class Header extends StatelessWidget {
  final List<Child> children;
  final ValueChanged<String?> onChildSelected;
  final String? selectedChildId;

  const Header({
    super.key,
    required this.children,
    required this.onChildSelected,
    this.selectedChildId,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Seleccionar niño:',
          style: textTheme.titleMedium!.copyWith(
            color: colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: selectedChildId,
          decoration: InputDecoration(
            filled: true,
            fillColor: colorScheme.surfaceContainerHighest,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
          hint: Text(
            'Todos los niños',
            style: textTheme.bodyLarge!.copyWith(color: colorScheme.onSurface.withAlpha((255 * 0.7).round())),
          ),
          onChanged: onChildSelected,
          items: [
            DropdownMenuItem(
              value: null,
              child: Text(
                'Todos los niños',
                style: textTheme.bodyLarge!.copyWith(color: colorScheme.onSurface),
              ),
            ),
            ...children.map((child) => DropdownMenuItem(
              value: child.id,
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 16,
                    backgroundImage: NetworkImage(child.imageUrl),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    child.name,
                    style: textTheme.bodyLarge!.copyWith(color: colorScheme.onSurface),
                  ),
                ],
              ),
            )),
          ],
        ),
      ],
    );
  }
}
