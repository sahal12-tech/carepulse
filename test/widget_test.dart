import 'package:flutter_test/flutter_test.dart';
import 'package:care_pulse/main.dart';

void main() {
  testWidgets('CarePulseApp renders initial screen smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const CarePulseApp());
    expect(find.text('CarePulse'), findsWidgets);
  });
}
