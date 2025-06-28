
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kids_clouds/core/theme_provider.dart';
import 'package:kids_clouds/ui/responsive/layout_helper.dart';
import 'package:kids_clouds/ui/screens/app_shell.dart';
import 'package:provider/provider.dart';

void main() {
  testWidgets('AppShell muestra icono menú en móvil', (WidgetTester tester) async {
  await tester.pumpWidget(
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: MediaQuery(
        data: const MediaQueryData(size: Size(400, 800)),
        child: const MaterialApp(home: AppShell()),
      ),
    ),
  );
  await tester.pumpAndSettle();

  expect(LayoutHelper.isMobile(tester.element(find.byType(AppShell))), isTrue);

    // Verificar que hay icono menú en AppBar
    expect(find.byIcon(Icons.menu), findsOneWidget);
  });
  testWidgets('AppShell muestra AppBar con título correcto', (WidgetTester tester) async {
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => ThemeProvider(),
        child: const MaterialApp(home: AppShell()),
      ),
    );
    await tester.pumpAndSettle();

    // Verifica que el AppBar tiene el título correcto
    expect(find.text('Inicio'), findsOneWidget);
  });
  testWidgets('AppShell muestra AppBar con título Agenda diaria', (WidgetTester tester) async {
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => ThemeProvider(),
        child: const MaterialApp(home: AppShell(initialPage: AppPage.agenda)),
      ),
    );
    await tester.pumpAndSettle();

    // Verifica que el AppBar tiene el título correcto
    expect(find.text('Agenda diaria'), findsOneWidget);
  });
  /*
  testWidgets('AppShell muestra Drawer en móvil', (WidgetTester tester) async {
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => ThemeProvider(),
        child: MediaQuery(
          data: const MediaQueryData(size: Size(400, 800)),
          child: const MaterialApp(home: AppShell()),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(LayoutHelper.isMobile(tester.element(find.byType(AppShell))), isTrue);

    // Verifica que el Drawer está presente
    expect(find.byType(Drawer), findsOneWidget);
  });
  testWidgets('AppShell no muestra Drawer en desktop', (WidgetTester tester) async {
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => ThemeProvider(),
        child: MediaQuery(
          data: const MediaQueryData(size: Size(1300, 800)),
          child: const MaterialApp(home: AppShell()),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(LayoutHelper.isDesktop(tester.element(find.byType(AppShell))), isTrue);

    // Verifica que el Drawer no está presente
    expect(find.byType(Drawer), findsNothing);
  });
  testWidgets('AppShell navega a página de agenda al seleccionar en el Drawer', (WidgetTester tester) async {
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => ThemeProvider(),
        child: MediaQuery(
          data: const MediaQueryData(size: Size(400, 800)),
          child: const MaterialApp(home: AppShell()),
        ),
      ),
    );
    await tester.pumpAndSettle();

    // Busca ListTile dentro del Drawer
    final agendaTile = find.descendant(
      of: find.byType(Drawer),
      matching: find.widgetWithText(ListTile, 'Agenda diaria'),
    );
    expect(agendaTile, findsOneWidget);

    await tester.tap(agendaTile);
    await tester.pumpAndSettle();

    // Verifica que el AppBar tiene el título correcto
    expect(find.text('Agenda diaria'), findsOneWidget);
  });
  */
}
