import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kids_clouds/ui/responsive/layout_helper.dart';

void main() {
  group('LayoutHelper', () {

    Widget buildTestWidgetWithWidth(double width) {

      return MaterialApp(
        home: MediaQuery(
          data: MediaQueryData(size: Size(width, 800)), // Set specific width, height doesn't matter for these tests
          child: Builder(
            builder: (BuildContext context) {
              // We return a SizedBox, as we just need the context, not to render anything
              return SizedBox(
                width: width,
                height: 800,
                // The Text widget requires a Directionality ancestor
                child: Text(width.toString()),
              );
            },
          ),
        ),
      );
    }

    testWidgets('isMobile returns true for widths less than 600', (WidgetTester tester) async {
      await tester.pumpWidget(buildTestWidgetWithWidth(320)); // iPhone SE width
      expect(LayoutHelper.isMobile(tester.element(find.byType(SizedBox))), isTrue);

      await tester.pumpWidget(buildTestWidgetWithWidth(599)); // Just under mobile breakpoint
      expect(LayoutHelper.isMobile(tester.element(find.byType(SizedBox))), isTrue);
    });

    testWidgets('isMobile returns false for widths 600 or greater', (WidgetTester tester) async {
      await tester.pumpWidget(buildTestWidgetWithWidth(600)); // Exactly at tablet breakpoint
      expect(LayoutHelper.isMobile(tester.element(find.byType(SizedBox))), isFalse);

      await tester.pumpWidget(buildTestWidgetWithWidth(1024)); // Desktop width
      expect(LayoutHelper.isMobile(tester.element(find.byType(SizedBox))), isFalse);
    });

    testWidgets('isTablet returns true for widths between 600 and 1023', (WidgetTester tester) async {
      await tester.pumpWidget(buildTestWidgetWithWidth(600)); // Exactly at tablet breakpoint
      expect(LayoutHelper.isTablet(tester.element(find.byType(SizedBox))), isTrue);

      await tester.pumpWidget(buildTestWidgetWithWidth(768)); // Typical tablet width
      expect(LayoutHelper.isTablet(tester.element(find.byType(SizedBox))), isTrue);

      await tester.pumpWidget(buildTestWidgetWithWidth(1023)); // Just under desktop breakpoint
      expect(LayoutHelper.isTablet(tester.element(find.byType(SizedBox))), isTrue);
    });

    testWidgets('isTablet returns false for widths less than 600 or 1024 and greater', (WidgetTester tester) async {
      await tester.pumpWidget(buildTestWidgetWithWidth(599)); // Mobile width
      expect(LayoutHelper.isTablet(tester.element(find.byType(SizedBox))), isFalse);

      await tester.pumpWidget(buildTestWidgetWithWidth(1024)); // Exactly at desktop breakpoint
      expect(LayoutHelper.isTablet(tester.element(find.byType(SizedBox))), isFalse);
    });

    testWidgets('isDesktop returns true for widths 1024 or greater', (WidgetTester tester) async {
      await tester.pumpWidget(buildTestWidgetWithWidth(1024)); // Exactly at desktop breakpoint
      expect(LayoutHelper.isDesktop(tester.element(find.byType(SizedBox))), isTrue);

      await tester.pumpWidget(buildTestWidgetWithWidth(1440)); // Common desktop width
      expect(LayoutHelper.isDesktop(tester.element(find.byType(SizedBox))), isTrue);
    });

    testWidgets('isDesktop returns false for widths less than 1024', (WidgetTester tester) async {
      await tester.pumpWidget(buildTestWidgetWithWidth(1023)); // Tablet width
      expect(LayoutHelper.isDesktop(tester.element(find.byType(SizedBox))), isFalse);

      await tester.pumpWidget(buildTestWidgetWithWidth(320)); // Mobile width
      expect(LayoutHelper.isDesktop(tester.element(find.byType(SizedBox))), isFalse);
    });
  });
}