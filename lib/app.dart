import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:kids_clouds/core/theme.dart';
import 'package:kids_clouds/core/theme_provider.dart';
import 'package:kids_clouds/ui/screens/app_shell.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            title: 'Kids Clouds',
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: themeProvider.themeMode,
            initialRoute: '/',
            routes: {
              '/': (context) => const AppShell(),
              '/home': (context) => const AppShell(initialPage: AppPage.home),
              '/agenda': (context) => const AppShell(initialPage: AppPage.agenda),
            },
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
}
