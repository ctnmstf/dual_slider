import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:dual_slider/dual_slider.dart';

void main() {
  testWidgets('DualSlider widget test', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: DualSlider(
            maxValue: 100,
            initialValue: 0,
            onChanged: (value) {},
          ),
        ),
      ),
    );

    // Verify that DualSlider is rendered
    expect(find.byType(DualSlider), findsOneWidget);
    expect(find.byType(Slider), findsOneWidget);
  });

  testWidgets('DualSlider with custom colors', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: DualSlider(
            maxValue: 50,
            trackColors: const [Colors.red, Colors.blue],
            thumbColor: Colors.green,
            onChanged: (value) {},
          ),
        ),
      ),
    );

    expect(find.byType(DualSlider), findsOneWidget);
  });

  testWidgets('DualSlider with tick marks', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: DualSlider(
            maxValue: 10,
            divisions: 4,
            showTickMarks: true,
            activeTickMarkColor: Colors.red,
            inactiveTickMarkColor: Colors.green,
            onChanged: (value) {},
          ),
        ),
      ),
    );

    expect(find.byType(DualSlider), findsOneWidget);
  });
}
