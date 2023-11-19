import 'package:flutter_test/flutter_test.dart';

import 'widget_test_helper_extensions.dart';

void main() {
  testWidgets('main app test', (tester) async {
    // Arrange
    await tester.pumpTvBuddyApp();

    // Act

    // Assert
    expect(find.text('TV Buddy'), findsOneWidget);
    expect(find.text('Trending'), findsOneWidget);
    expect(find.text('Section A'), findsOneWidget);
    expect(find.text('Section B'), findsOneWidget);
  });
}
