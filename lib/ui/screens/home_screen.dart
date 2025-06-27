import 'package:flutter/material.dart';

class HomeScreenContent extends StatelessWidget {
  const HomeScreenContent({super.key});

  @override
  Widget build(BuildContext context) {

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.network(
            'https://kidsnclouds.es/wp-content/uploads/2024/08/KNC-Sergio-Mix2-1.png',
            width: 200,
            height: 200,
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) {
              return const Icon(Icons.error, size: 100);
            },
          ),
          const SizedBox(height: 24),
          Text(
            'Bienvenido a Kids Clouds',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          const Text(
            'Usa el menú lateral para acceder a la Agenda diaria.',
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
