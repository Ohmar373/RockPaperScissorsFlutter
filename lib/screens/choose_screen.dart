import 'package:flutter/material.dart';
import 'package:final_proj/models/game_state.dart';
import 'computer_selection_screen.dart';

class ChooseScreen extends StatefulWidget {
  final GameState gameState;
  final String? forcedComputerMove;

  const ChooseScreen({
    super.key,
    required this.gameState,
    this.forcedComputerMove,
  });

  @override
  State<ChooseScreen> createState() => _ChooseScreenState();
}

class _ChooseScreenState extends State<ChooseScreen> {
  String? _selectedMove;

  void _onChoice(String move) {
    setState(() {
      _selectedMove = move;
    });
  }

  void _onContinue(BuildContext context) {
    if (_selectedMove == null) return;

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => ComputerSelectionScreen(
          playerMove: _selectedMove!,
          gameState: widget.gameState,
          forcedComputerMove: widget.forcedComputerMove, 
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color.fromRGBO(75, 154, 210, 1);

    return Scaffold(
    backgroundColor: primaryColor,
    body: Center(
      child: SingleChildScrollView(
        child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
            const Text(
              'Choose:',
              style: TextStyle(
                fontSize: 70,
                fontFamily: 'Monofett',
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 24),

            // Rock
            SizedBox(
              width: 130.0,
              height: 130.0,
              child: ElevatedButton(
                key: const Key('rock-button'),
                onPressed: () => _onChoice('Move.Rock'),
                style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(),
                  padding: EdgeInsets.zero,
                ),
                child: ClipOval(
                  child: Image.asset(
                    'assets/images/rock.png',
                    fit: BoxFit.cover,
                    width: 130.0,
                    height: 130.0,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),

            // Paper
            SizedBox(
              width: 130.0,
              height: 130.0,
              child: ElevatedButton(
                key: const Key('paper-button'),
                onPressed: () => _onChoice('Move.Paper'),
                style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(),
                  padding: EdgeInsets.zero,
                ),
                child: ClipOval(
                  child: Image.asset(
                    'assets/images/paper.png',
                    fit: BoxFit.cover,
                    width: 130.0,
                    height: 130.0,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),

            // Scissors
            SizedBox(
              width: 130.0,
              height: 130.0,
              child: ElevatedButton(
                key: const Key('scissors-button'),
                onPressed: () => _onChoice('Move.Scissors'),
                style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(),
                  padding: EdgeInsets.zero,
                ),
                child: ClipOval(
                  child: Image.asset(
                    'assets/images/scissors.png',
                    fit: BoxFit.cover,
                    width: 130.0,
                    height: 130.0,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 28),

            // Continue
            SizedBox(
              width: 330,
              height: 180,
              child: TextButton(
                key: const Key('continue'), 
                onPressed:
                    _selectedMove == null ? null : () => _onContinue(context),
                style: TextButton.styleFrom(
                  backgroundColor: primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  'Continue',
                  style: TextStyle(
                    fontFamily: 'Monofett',
                    fontSize: 60,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
