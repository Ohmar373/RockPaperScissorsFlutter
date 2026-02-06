/// Tracks game state across best-of-3 rounds.
class GameState {
  int wins = 0;
  int losses = 0;
  int ties = 0;

  /// True if the best-of-3 is over (2 wins or 2 losses).
  bool get isGameOver => wins >= 2 || losses >= 2;

  /// True if the player won the overall match.
  bool get playerWon => wins >= 2;

  /// Resets the game state for a new match.
  void reset() {
    wins = 0;
    losses = 0;
    ties = 0;
  }

  /// Returns a list of symbols for the 3 boxes: 'W' for win, 'L' for loss, '-' for tie.
  List<String> getScoreboard() {
    final list = <String>[];
    for (int i = 0; i < wins; i++) list.add('O');
    for (int i = 0; i < losses; i++) list.add('X');
    for (int i = 0; i < ties; i++) list.add('-');
    // Pad to 3 boxes
    while (list.length < 3) list.add('');
    return list.take(3).toList();
  }
}
