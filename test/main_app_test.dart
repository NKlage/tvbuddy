import 'package:flutter_test/flutter_test.dart';
import 'package:tvbuddy/main.dart';

void main() {
  testWidgets('main app test', (tester) async {
    // Arrange
    await tester.pumpWidget(const MainApp());

    // Act

    // Assert
    expect(
      find.text(
          'This product uses the TMDB API but is not endorsed or certified by '
          'TMDB.'),
      findsOneWidget,
    );
  });
}
