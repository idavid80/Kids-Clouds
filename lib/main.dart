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
