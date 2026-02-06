import 'package:flutter/material.dart';
import 'package:final_proj/models/game_state.dart';
import 'package:final_proj/screens/choose_screen.dart';
import 'package:final_proj/screens/final_win.dart';
import 'package:final_proj/screens/final_lose.dart';

class TieScreen extends StatelessWidget {
  final String playerMove;
  final String computerMove;
  final GameState gameState;

  const TieScreen({
    super.key,
    required this.playerMove,
    required this.computerMove,
    required this.gameState,
  });

  static const primaryColor = Color.fromRGBO(75, 154, 210, 1);

  void _onDone(BuildContext context) {
    if (gameState.isGameOver) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => gameState.playerWon
              ? FinalWinScreen(
                  playerMove: playerMove,
                  computerMove: computerMove,
                  gameState: gameState,
                )
              : FinalLoseScreen(
                  playerMove: playerMove,
                  computerMove: computerMove,
                  gameState: gameState,
                ),
        ),
      );
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => ChooseScreen(gameState: gameState),
        ),
      );
    }
  }

  String _assetForMove(String move) {
    return 'assets/images/${move.replaceAll('Move.', '').toLowerCase()}.png';
  }

  Widget _moveCircle({required String asset, required Key key}) {
    return SizedBox(
      key: key, 
      width: 130,
      height: 130,
      child: ElevatedButton(
        onPressed: null,
        style: ElevatedButton.styleFrom(
          shape: const CircleBorder(),
          padding: EdgeInsets.zero,
          elevation: 0,
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
        ),
        child: ClipOval(
          child: Image.asset(
            asset,
            key: Key('${(key as ValueKey).value}-img'), // optional image key
            width: 130,
            height: 130,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  String? _iconForSymbol(String symbol) {
    // GameState.getScoreboard():
    // 'O' = win, 'X' = loss, '-' = tie, '' = empty
    if (symbol == 'O') return 'assets/images/check.png';
    if (symbol == 'X') return 'assets/images/cross.png';
    return null; // ties show empty box
  }

  // ✅ score box + image keys for testing
  Widget _scoreBox({
    required int index,
    required String symbol,
  }) {
    final icon = _iconForSymbol(symbol);

    final boxKey = Key('score-box-$index-$symbol'); // ex: score-box-0-O / score-box-2-
    final imageKey = Key('score-icon-$index-$symbol'); // ex: score-icon-1-X

    return Container(
      key: boxKey,
      width: 62,
      height: 62,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: icon == null
          ? null
          : ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                icon,
                key: imageKey,
                fit: BoxFit.cover,
              ),
            ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final playerAsset = _assetForMove(playerMove);
    final cpuAsset = _assetForMove(computerMove);
    final scoreboard = gameState.getScoreboard();

    return Scaffold(
      backgroundColor: primaryColor,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 24),
            const Text(
              'ROUND TIE!',
              style: TextStyle(
                fontFamily: 'Monofett',
                fontSize: 60,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'YOU',
                    style: TextStyle(
                      fontFamily: 'Monofett',
                      fontSize: 42,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'CPU',
                    style: TextStyle(
                      fontFamily: 'Monofett',
                      fontSize: 42,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _moveCircle(
                    asset: playerAsset,
                    key: const Key('player-move'),
                  ),
                  const Text(
                    'vs',
                    style: TextStyle(
                      fontFamily: 'Monofett',
                      fontSize: 32,
                      color: Colors.white,
                    ),
                  ),
                  _moveCircle(
                    asset: cpuAsset,
                    key: const Key('cpu-move'),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 36),

            SizedBox(
              width: 240,
              height: 74,
              child: ElevatedButton(
                key: const Key('done'), // ✅ key goes on the BUTTON
                onPressed: () => _onDone(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 255, 148, 212),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40),
                  ),
                ),
                child: const Text(
                  'DONE',
                  style: TextStyle(
                    fontFamily: 'Monofett',
                    fontSize: 36,
                    color: Colors.white,
                  ),
                ),
              ),
            ),

            const Spacer(),

            Padding(
              padding: const EdgeInsets.only(bottom: 26),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(3, (index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 9),
                    child: _scoreBox(
                      index: index,
                      symbol: scoreboard[index],
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
