import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_starter_kit/main.dart';

void main() {
  testWidgets('App launches with Login screen smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const DummyJsonApp());

    // Verify that the login screen title and sign in button are displayed
    expect(find.text('DummyJSON Store'), findsOneWidget);
    expect(find.text('Sign In'), findsOneWidget);
  });
}
