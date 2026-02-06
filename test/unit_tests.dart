import 'package:flutter_test/flutter_test.dart';
import 'package:final_proj/utils/tools.dart';

void main() {
  group("Game Logic, Player Wins and Ties: ", () {
    test('Paper beats Rock', () {
      final winner = determineWinner('Move.Paper', 'Move.Rock');
      expect(winner, equals(Winner.Player));
    });

    test('Rock beats Scissors', () {
      final winner = determineWinner('Move.Rock', 'Move.Scissors');
      expect(winner, equals(Winner.Player));
    });

    test('Scissors beats Paper', () {
      final winner = determineWinner('Move.Scissors', 'Move.Paper');
      expect(winner, equals(Winner.Player));
    });

    test('Rock vs Rock is a tie', () {
      final winner = determineWinner('Move.Rock', 'Move.Rock');
      expect(winner, equals(Winner.Draw));
    });

    test('Paper vs Paper is a tie', () {
      final winner = determineWinner('Move.Paper', 'Move.Paper');
      expect(winner, equals(Winner.Draw));
    });

    test('Scissors vs Scissors is a tie', () {
      final winner = determineWinner('Move.Scissors', 'Move.Scissors');
      expect(winner, equals(Winner.Draw));
    });
  });

  group("Game Logic, Computer Wins and Ties: ", () {
    test('Rock loses to Paper', () {
      final winner = determineWinner('Move.Rock', 'Move.Paper');
      expect(winner, equals(Winner.Computer));
    });

    test('Scissors loses to Rock', () {
      final winner = determineWinner('Move.Scissors', 'Move.Rock');
      expect(winner, equals(Winner.Computer));
    });

    test('Paper loses to Scissors', () {
      final winner = determineWinner('Move.Paper', 'Move.Scissors');
      expect(winner, equals(Winner.Computer));
    });

    test('Rock vs Rock is a tie', () {
      final winner = determineWinner('Move.Rock', 'Move.Rock');
      expect(winner, equals(Winner.Draw));
    });

    test('Paper vs Paper is a tie', () {
      final winner = determineWinner('Move.Paper', 'Move.Paper');
      expect(winner, equals(Winner.Draw));
    });

    test('Scissors vs Scissors is a tie', () {
      final winner = determineWinner('Move.Scissors', 'Move.Scissors');
      expect(winner, equals(Winner.Draw));
    });
  });


}