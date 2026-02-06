import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:final_proj/models/game_state.dart';
import 'package:final_proj/utils/tools.dart';
import 'package:final_proj/screens/win_screen.dart';
import 'package:final_proj/screens/lose_screen.dart';
import 'package:final_proj/screens/tie_screen.dart';

class ComputerSelectionScreen extends StatefulWidget {
  final String playerMove;
  final GameState gameState;
  final String? forcedComputerMove; // FOR TESTS

  const ComputerSelectionScreen({
    super.key,
    required this.playerMove,
    required this.gameState,
    this.forcedComputerMove, // FOR TESTS
  });

  @override
  State<ComputerSelectionScreen> createState() => _ComputerSelectionScreenState();
}

class _ComputerSelectionScreenState extends State<ComputerSelectionScreen> {
  late final String _computerMove;
  late final Winner _roundWinner;

  String _computerMoveAsset() {
    switch (_computerMove) {
      case 'Move.Rock':
        return 'assets/images/rock.png';
      case 'Move.Paper':
        return 'assets/images/paper.png';
      case 'Move.Scissors':
        return 'assets/images/scissors.png';
      default:
        return 'assets/images/rock.png';
    }
  }

  @override
void initState() {
  super.initState();

  _computerMove = widget.forcedComputerMove ?? _pickRandomComputerMove(); // ✅
  _roundWinner = determineWinner(widget.playerMove, _computerMove);

  switch (_roundWinner) {
    case Winner.Player:
      widget.gameState.wins++;
      break;
    case Winner.Computer:
      widget.gameState.losses++;
      break;
    case Winner.Draw:
      widget.gameState.ties++;
      break;
  }

  Timer(const Duration(seconds: 4), _navigateToResultScreen);
}

  void _navigateToResultScreen() {
    if (!mounted) return;

    late final Widget nextScreen;
    switch (_roundWinner) {
      case Winner.Player:
        nextScreen = WinScreen(
          playerMove: widget.playerMove,
          computerMove: _computerMove,
          gameState: widget.gameState,
        );
        break;
      case Winner.Computer:
        nextScreen = LoseScreen(
          playerMove: widget.playerMove,
          computerMove: _computerMove,
          gameState: widget.gameState,
        );
        break;
      case Winner.Draw:
        nextScreen = TieScreen(
          playerMove: widget.playerMove,
          computerMove: _computerMove,
          gameState: widget.gameState,
        );
        break;
    }

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => nextScreen),
    );
  }

  String _pickRandomComputerMove() {
  if (widget.forcedComputerMove != null) {
    return widget.forcedComputerMove!;
  }

  final options = ['Move.Rock', 'Move.Paper', 'Move.Scissors'];
  final idx = Random().nextInt(options.length);
  return options[idx];
}


  String _pretty(String move) => move.replaceAll('Move.', '');

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color.fromRGBO(75, 154, 210, 1);
    return Scaffold(
      backgroundColor: primaryColor,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 12),
            Text(
              'Computer chose: ${_pretty(_computerMove)}',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 70,
                fontFamily: 'Monofett',
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 24),

            SizedBox(
              width: 130,
              height: 130,
              child: ClipOval(
                child: Image.asset(
                  _computerMoveAsset(),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
