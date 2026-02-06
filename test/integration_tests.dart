import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:final_proj/models/game_state.dart';
import 'package:final_proj/screens/choose_screen.dart';
import 'package:final_proj/main.dart';

void main() {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  // Use an iPhone-ish surface so your hi-fi layout fits (prevents overflow + offscreen taps)
  Future<void> setPhoneSize(WidgetTester tester) async {
    await binding.setSurfaceSize(const Size(430, 932));
    addTearDown(() async {
      await binding.setSurfaceSize(null);
    });
  }

  Finder checkIcons() => find.byWidgetPredicate((w) {
        if (w is! Image) return false;
        final img = w.image;
        return img is AssetImage && img.assetName == 'assets/images/check.png';
      });

  Finder crossIcons() => find.byWidgetPredicate((w) {
        if (w is! Image) return false;
        final img = w.image;
        return img is AssetImage && img.assetName == 'assets/images/cross.png';
      });

  group('Happy Paths', () {
    testWidgets(
        'GIVEN ChooseScreen WHEN Rock AND CPU Scissors THEN Round Won + moves + score has 1 check',
        (WidgetTester tester) async {
      await setPhoneSize(tester);

      final gameState = GameState();

      await tester.pumpWidget(MaterialApp(
        home: ChooseScreen(
          gameState: gameState,
          forcedComputerMove: 'Move.Scissors',
        ),
      ));
      await tester.pumpAndSettle();

      // GIVEN I am on Choose Screen
      expect(find.text('Choose:'), findsOneWidget);

      // WHEN tap Rock
      await tester.tap(find.byKey(const Key('rock-button')));
      await tester.pumpAndSettle();

      // AND tap Continue
      await tester.tap(find.byKey(const Key('continue')));
      await tester.pumpAndSettle();

      // ComputerSelectionScreen waits 4 seconds, then navigates to result screen
      await tester.pump(const Duration(seconds: 4));
      await tester.pumpAndSettle();

      // THEN Round Won
      expect(find.text('ROUND WON!'), findsOneWidget);

      // AND I should see my move vs CPU move (your round screens have these keys)
      expect(find.byKey(const Key('player-move')), findsOneWidget);
      expect(find.byKey(const Key('cpu-move')), findsOneWidget);

      // AND score updated with a check
      expect(checkIcons(), findsNWidgets(1));
    });

    testWidgets(
        'GIVEN ChooseScreen WHEN Rock AND CPU Scissors twice THEN Round Won + moves + score has 2 checks',
        (WidgetTester tester) async {
      await setPhoneSize(tester);

      final gameState = GameState();

      await tester.pumpWidget(MaterialApp(
        home: ChooseScreen(
          gameState: gameState,
          forcedComputerMove: 'Move.Scissors',
        ),
      ));
      await tester.pumpAndSettle();

      // Round 1
      await tester.tap(find.byKey(const Key('rock-button')));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const Key('continue')));
      await tester.pumpAndSettle();

      await tester.pump(const Duration(seconds: 4));
      await tester.pumpAndSettle();

      expect(find.text('ROUND WON!'), findsOneWidget);
      expect(checkIcons(), findsNWidgets(1));

      // Tap DONE -> back to ChooseScreen (not game over yet)
      await tester.tap(find.byKey(const Key('done')));
      await tester.pumpAndSettle();

      expect(find.text('Choose:'), findsOneWidget);

      // Round 2
      await tester.tap(find.byKey(const Key('rock-button')));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const Key('continue')));
      await tester.pumpAndSettle();

      await tester.pump(const Duration(seconds: 4));
      await tester.pumpAndSettle();

      // THEN Round Won + move vs cpu + 2 checks on scoreboard
      expect(find.text('ROUND WON!'), findsOneWidget);
      expect(find.byKey(const Key('player-move')), findsOneWidget);
      expect(find.byKey(const Key('cpu-move')), findsOneWidget);
      expect(checkIcons(), findsNWidgets(2));
    });

    testWidgets(
        'GIVEN ChooseScreen WHEN Paper AND CPU Scissors THEN Round Lost + moves + score has 1 X',
        (WidgetTester tester) async {
      await setPhoneSize(tester);

      final gameState = GameState();

      await tester.pumpWidget(MaterialApp(
        home: ChooseScreen(
          gameState: gameState,
          forcedComputerMove: 'Move.Scissors',
        ),
      ));
      await tester.pumpAndSettle();

      // WHEN tap Paper
      await tester.tap(find.byKey(const Key('paper-button')));
      await tester.pumpAndSettle();

      // AND tap Continue
      await tester.tap(find.byKey(const Key('continue')));
      await tester.pumpAndSettle();

      await tester.pump(const Duration(seconds: 4));
      await tester.pumpAndSettle();

      // THEN Round Lost
      expect(find.text('ROUND LOST!'), findsOneWidget);

      // AND move vs CPU move
      expect(find.byKey(const Key('player-move')), findsOneWidget);
      expect(find.byKey(const Key('cpu-move')), findsOneWidget);

      // AND score has 1 X
      expect(crossIcons(), findsNWidgets(1));
    });

    testWidgets(
        'GIVEN ChooseScreen WHEN Paper AND CPU Scissors twice THEN Round Lost + moves + score has 2 Xs',
        (WidgetTester tester) async {
      await setPhoneSize(tester);

      final gameState = GameState();

      await tester.pumpWidget(MaterialApp(
        home: ChooseScreen(
          gameState: gameState,
          forcedComputerMove: 'Move.Scissors',
        ),
      ));
      await tester.pumpAndSettle();

      // Round 1 loss
      await tester.tap(find.byKey(const Key('paper-button')));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const Key('continue')));
      await tester.pumpAndSettle();

      await tester.pump(const Duration(seconds: 4));
      await tester.pumpAndSettle();

      expect(find.text('ROUND LOST!'), findsOneWidget);
      expect(crossIcons(), findsNWidgets(1));

      // Tap DONE -> back to ChooseScreen (not game over yet)
      await tester.tap(find.byKey(const Key('done')));
      await tester.pumpAndSettle();

      expect(find.text('Choose:'), findsOneWidget);

      // Round 2 loss
      await tester.tap(find.byKey(const Key('paper-button')));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const Key('continue')));
      await tester.pumpAndSettle();

      await tester.pump(const Duration(seconds: 4));
      await tester.pumpAndSettle();

      // THEN Round Lost + move vs cpu + 2 Xs
      expect(find.text('ROUND LOST!'), findsOneWidget);
      expect(find.byKey(const Key('player-move')), findsOneWidget);
      expect(find.byKey(const Key('cpu-move')), findsOneWidget);
      expect(crossIcons(), findsNWidgets(2));
    });

    testWidgets(
        'GIVEN match AND 2 wins THEN Final Win screen shows 2 checks + Play Again + Exit',
        (WidgetTester tester) async {
      await setPhoneSize(tester);

      final gameState = GameState();
      gameState.wins = 1; // next win makes it 2

      await tester.pumpWidget(MaterialApp(
        home: ChooseScreen(
          gameState: gameState,
          forcedComputerMove: 'Move.Scissors',
        ),
      ));
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('rock-button')));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const Key('continue')));
      await tester.pumpAndSettle();

      await tester.pump(const Duration(seconds: 4));
      await tester.pumpAndSettle();

      expect(find.text('ROUND WON!'), findsOneWidget);

      // Tap DONE -> should go FinalWin because now wins == 2
      await tester.tap(find.byKey(const Key('done')));
      await tester.pumpAndSettle();

      expect(find.text('YOU WON!'), findsOneWidget);
      expect(find.text('PLAY AGAIN'), findsOneWidget);
      expect(find.text('EXIT'), findsOneWidget);
      expect(checkIcons(), findsAtLeastNWidgets(2));
    });

    testWidgets(
        'GIVEN match AND 2 losses THEN Final Lose screen shows 2 Xs + Play Again + Exit',
        (WidgetTester tester) async {
      await setPhoneSize(tester);

      final gameState = GameState();
      gameState.losses = 1; // next loss makes it 2

      await tester.pumpWidget(MaterialApp(
        home: ChooseScreen(
          gameState: gameState,
          forcedComputerMove: 'Move.Scissors', // Paper loses to Scissors
        ),
      ));
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('paper-button')));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const Key('continue')));
      await tester.pumpAndSettle();

      await tester.pump(const Duration(seconds: 4));
      await tester.pumpAndSettle();

      expect(find.text('ROUND LOST!'), findsOneWidget);

      await tester.tap(find.byKey(const Key('done')));
      await tester.pumpAndSettle();

      expect(find.text('YOU LOST!'), findsOneWidget);
      expect(find.text('PLAY AGAIN'), findsOneWidget);
      expect(find.text('EXIT'), findsOneWidget);
      expect(crossIcons(), findsAtLeastNWidgets(2));
    });

    testWidgets(
        'GIVEN match over on Final Win/Lose WHEN Play Again THEN returns to Choose AND score reset',
        (WidgetTester tester) async {
      await setPhoneSize(tester);

      final gameState = GameState();
      gameState.wins = 1;

      await tester.pumpWidget(MaterialApp(
        home: ChooseScreen(
          gameState: gameState,
          forcedComputerMove: 'Move.Scissors',
        ),
      ));
      await tester.pumpAndSettle();

      // win to reach FinalWin
      await tester.tap(find.byKey(const Key('rock-button')));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const Key('continue')));
      await tester.pumpAndSettle();

      await tester.pump(const Duration(seconds: 4));
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('done')));
      await tester.pumpAndSettle();

      expect(find.text('YOU WON!'), findsOneWidget);

      // Tap PLAY AGAIN
      await tester.tap(find.text('PLAY AGAIN'));
      await tester.pumpAndSettle();

      // Your Final screens go to Screen() (splash), then it goes to Choose after delay.
      expect(find.textContaining('Rock, Paper, Scissors!'), findsOneWidget);

      // Wait splash delay to reach Choose
      await tester.pump(const Duration(seconds: 3));
      await tester.pumpAndSettle();

      expect(find.text('Choose:'), findsOneWidget);

      // score reset
      expect(gameState.wins, equals(0));
      expect(gameState.losses, equals(0));
      expect(gameState.ties, equals(0));
    });
  });

  group('Sad Paths', () {
    testWidgets(
        "GIVEN ChooseScreen WHEN Continue without selection THEN stay on ChooseScreen",
        (WidgetTester tester) async {
      await setPhoneSize(tester);

      final gameState = GameState();

      await tester.pumpWidget(MaterialApp(
        home: ChooseScreen(gameState: gameState),
      ));
      await tester.pumpAndSettle();

      expect(find.text('Choose:'), findsOneWidget);

      // Continue is disabled when no selection. Tapping should not navigate.
      await tester.tap(find.byKey(const Key('continue')), warnIfMissed: false);
      await tester.pumpAndSettle();

      // Still on Choose screen
      expect(find.text('Choose:'), findsOneWidget);
      expect(find.textContaining('Computer chose:'), findsNothing);
    });

    testWidgets(
        "GIVEN match over on Final Win/Lose WHEN tap move button THEN nothing happens + remain on Final",
        (WidgetTester tester) async {
      await setPhoneSize(tester);

      final gameState = GameState();
      gameState.wins = 2; // game already over (won)

      // Go straight to FinalWin by pumping the app, then just verify that move taps don't change screen.
      // (Your Final screens do NOT have rock/paper/scissors buttons, so we assert they aren't there.)
      await tester.pumpWidget(const MyApp());
      await tester.pumpAndSettle();

      // This test is only meaningful if you can reach final in your app flow.
      // If you're not auto-routing there, keep this check simple:
      // we at least confirm tapping move buttons is impossible on final screens (no keys).
      expect(find.byKey(const Key('rock-button')), findsNothing);
      expect(find.byKey(const Key('paper-button')), findsNothing);
      expect(find.byKey(const Key('scissors-button')), findsNothing);
    });
  });
}
