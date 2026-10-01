import 'package:flutter_test/flutter_test.dart';

import 'package:exre/main.dart';

void main() {
  testWidgets('ExreApp arranca y muestra la pantalla de Inicio', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const ExreApp());

    expect(find.text('ExRE'), findsOneWidget);
  });
}
