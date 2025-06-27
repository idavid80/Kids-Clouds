import 'package:flutter/material.dart';

class ParentProfileHeader extends StatelessWidget {
  final String parentName;
  final String parentImageUrl;

  const ParentProfileHeader({
    super.key,
    required this.parentName,
    required this.parentImageUrl,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return LayoutBuilder(
      builder: (context, constraints) {
        final double avatarRadius = constraints.maxWidth < 300 ? 24 : 30;
        final double fontSize = constraints.maxWidth < 300 ? 16 : 20;
        final double spacing = constraints.maxWidth < 300 ? 6 : 8;

        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              CircleAvatar(
                radius: avatarRadius,
                backgroundImage: NetworkImage(parentImageUrl),
                backgroundColor: colorScheme.onPrimary,
              ),
              SizedBox(width: spacing),
              Expanded(
                child: Text(
                  parentName,
                  style: textTheme.headlineSmall!.copyWith(
                    color: colorScheme.onPrimary,
                    fontWeight: FontWeight.bold,
                    fontSize: fontSize,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
