import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tictactoe/custom_dilogue.dart';

void main() {
  testWidgets('AlertDialog Test', (WidgetTester tester) async {
    bool callbackCalled = false; // Variable to track if the callback is called

    // Build our app and trigger a frame.
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (BuildContext context) {
              return ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Test Title'),
                        content: Text('Test Content'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              callbackCalled =
                                  true; // Set the variable to true when the button is pressed
                              Navigator.pop(context); // Close the dialog
                            },
                            child: Text('Ok'),
                            style: TextButton.styleFrom(
                              foregroundColor: Colors.black,
                            ),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: Text('Show Dialog'),
              );
            },
          ),
        ),
      ),
    );

    // Verify that the initial state is correct.
    expect(find.text('Test Title'), findsNothing);
    expect(find.text('Test Content'), findsNothing);
    expect(callbackCalled,
        isFalse); // Ensure that the callback is not called initially

    // Tap the ElevatedButton to show the AlertDialog
    await tester.tap(find.text('Show Dialog'));

    // Wait for the frame to be rebuilt.
    await tester.pump();

    // Verify that the AlertDialog is displayed.
    expect(find.text('Test Title'), findsOneWidget);
    expect(find.text('Test Content'), findsOneWidget);
    expect(callbackCalled,
        isFalse); // Ensure that the callback is still not called

    // Tap the Ok button inside the AlertDialog
    await tester.tap(find.text('Ok'));

    // Wait for the frame to be rebuilt.
    await tester.pump();

    // Verify that the callback is called after tapping the Ok button.
    expect(callbackCalled, isTrue);

    // Verify that the AlertDialog is closed.
    expect(find.text('Test Title'), findsNothing);
    expect(find.text('Test Content'), findsNothing);
  });
}
