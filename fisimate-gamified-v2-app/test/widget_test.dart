import 'package:flutter_test/flutter_test.dart';

import 'package:fisimate/main.dart';

void main() {
  testWidgets('App boots to splash screen without throwing', (WidgetTester tester) async {
    await tester.pumpWidget(const FisimateApp());
    await tester.pump();

    expect(tester.takeException(), isNull);
  });
}
