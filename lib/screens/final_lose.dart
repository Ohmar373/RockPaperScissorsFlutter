import 'package:flutter/material.dart';
import 'package:final_proj/models/game_state.dart';
import 'package:final_proj/screens/splash_screen.dart';

class FinalLoseScreen extends StatelessWidget {
  final String playerMove;
  final String computerMove;
  final GameState gameState;

  const FinalLoseScreen({
    super.key,
    required this.playerMove,
    required this.computerMove,
    required this.gameState,
  });

  static const primaryColor = Color.fromRGBO(75, 154, 210, 1);
  static const secondColor = Color.fromRGBO(148, 212, 255, 1);

  String _assetForMove(String move) {
    return 'assets/images/${move.replaceAll('Move.', '').toLowerCase()}.png';
  }

  Widget _moveCircle({required String asset}) {
    return SizedBox(
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
            width: 130,
            height: 130,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget _scoreBox(String? icon) {
  return Container(
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
              fit: BoxFit.cover, // fills the box completely
            ),
          ),
  );
}


  String? _iconForSymbol(String symbol) {
    if (symbol == 'O') return 'assets/images/check.png';
    if (symbol == 'X') return 'assets/images/cross.png';
    return null;
  }

  void _playAgain(BuildContext context) {
    gameState.reset();
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const Screen()),
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
              'YOU LOST!',
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
                  _moveCircle(asset: playerAsset),
                  const Text(
                    'vs',
                    style: TextStyle(
                      fontFamily: 'Monofett',
                      fontSize: 32,
                      color: Colors.white,
                    ),
                  ),
                  _moveCircle(asset: cpuAsset),
                ],
              ),
            ),

            const SizedBox(height: 28),

           Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 170,
                    height: 70,
                    child: ElevatedButton(
                      onPressed: () => _playAgain(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: secondColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40),
                        ),
                      ),
                      child: const Text(
                        'PLAY AGAIN',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Monofett',
                          fontSize: 26,
                          color: Colors.white,
                          height: 1.0,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(
                    width: 170,
                    height: 70,
                    child: ElevatedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: secondColor,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40),
                        ),
                      ),
                      child: const Text(
                        'EXIT',
                        style: TextStyle(
                          fontFamily: 'Monofett',
                          fontSize: 26,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const Spacer(),

            // Bottom scoreboard
            Padding(
              padding: const EdgeInsets.only(bottom: 26),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(3, (index) {
                  final symbol = scoreboard[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 9),
                    child: _scoreBox(_iconForSymbol(symbol)),
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
