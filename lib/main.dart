import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kids_clouds/app.dart'; // Importa el widget App
import 'package:kids_clouds/data/mock_data.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // initialize mock data
  initializeMockData();

  // Ejecuta la aplicación. El widget App ahora contendrá el MaterialApp y el ThemeProvider.
  runApp(const App());
}
/*
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kids_clouds/app.dart';
import 'package:kids_clouds/core/theme.dart';
import 'package:kids_clouds/data/mock_data.dart';

void main() {

  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // initialize mock data
  initializeMockData();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kids Clouds',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      home: const App(),
    );
  }
}
*/