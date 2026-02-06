
enum Winner { Player, Computer, Draw }

Winner determineWinner(String playerMove, String computerMove) {
  final player = _normalizeMove(playerMove);
  final computer = _normalizeMove(computerMove);

  if (player == computer) return Winner.Draw;

  if (_beats(player, computer)) return Winner.Player;

  return Winner.Computer;
}

String _normalizeMove(String move) {
  
  final parts = move.split('.');
  final raw = parts.isNotEmpty ? parts.last : move;
  return raw.trim().toLowerCase();
}

bool _beats(String a, String b) {
  // returns true if move `a` beats move `b`
  if (a == 'rock' && b == 'scissors') return true;
  if (a == 'scissors' && b == 'paper') return true;
  if (a == 'paper' && b == 'rock') return true;
  return false;
}

class RockPaperScissorsTool {
  static const String rock = 'rock';
  static const String paper = 'paper';
  static const String scissors = 'scissors';

  /// Old API kept for compatibility: returns "win"/"lose"/"tie".
  static String play(String player, String opponent) {
    final p = _normalizeMove(player);
    final o = _normalizeMove(opponent);
    if (p == o) return 'tie';
    if (_beats(p, o)) return 'win';
    return 'lose';
  }
}
