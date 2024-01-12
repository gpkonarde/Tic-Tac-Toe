import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tictactoe/custom_dilogue.dart';
import 'package:tictactoe/home_page.dart';

void main() {
  group('HomePage Widget Tests', () {
    testWidgets('Initial State Test', (WidgetTester tester) async {
      // Build our app and trigger a frame.
      await tester.pumpWidget(MaterialApp(home: HomePage()));

      // Verify the initial state of the game board.
      expect(find.byType(ElevatedButton), findsNWidgets(6));

      // Ensure that no buttons have X or O text initially
      expect(find.text('X'), findsNothing);
      expect(find.text('O'), findsNothing);
    });

    testWidgets('Play Game and Reset Test', (WidgetTester tester) async {
      // Build our app and trigger a frame.
      await tester.pumpWidget(MaterialApp(home: HomePage()));

      // Play the game by tapping on buttons
      await tester.tap(find.byType(ElevatedButton).first);
      await tester.pump();

      // Verify that the game state is updated
      expect(find.text('X'), findsOneWidget);

      // Reset the game
      await tester.tap(find.byType(FloatingActionButton));
      await tester.pump();

      // Verify that the game is reset
      expect(find.text('X'), findsNothing);
      expect(find.text('O'), findsNothing);
    });

    testWidgets('Player 1 Win Dialog Test', (WidgetTester tester) async {
      // Build our app and trigger a frame.
      await tester.pumpWidget(MaterialApp(home: HomePage()));

      // Play the game for Player 1 win
      await tester.tap(find.byType(ElevatedButton).at(0));
      await tester.pump();
      await tester.tap(find.byType(ElevatedButton).at(3));
      await tester.pump();
      await tester.tap(find.byType(ElevatedButton).at(1));
      await tester.pump();
      await tester.tap(find.byType(ElevatedButton).at(4));
      await tester.pump();
      await tester.tap(find.byType(ElevatedButton).at(2));
      await tester.pump();

      // Verify the Player 1 win dialog
      expect(find.byType(CustomDilogue), findsOneWidget);
      expect(find.text('Player 1 won'), findsOneWidget);
    });
  });
}
