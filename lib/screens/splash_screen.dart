import 'package:flutter/material.dart';
import 'package:final_proj/models/game_state.dart';
import 'package:final_proj/screens/choose_screen.dart';

class Screen extends StatefulWidget {
  const Screen({super.key});

  @override
  State<Screen> createState() => _ScreenState();
}

class _ScreenState extends State<Screen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (_) => ChooseScreen(gameState: GameState()),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color.fromRGBO(75, 154, 210, 1);
    const secondColo = Color.fromRGBO(148, 212, 255, 1);
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/background.png',
              fit: BoxFit.cover,
        ),
      ),

      // foreground UI
      Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              textAlign: TextAlign.center,
              'Rock, Paper, Scissors!',
              style: TextStyle(
                fontSize: 70,
                fontFamily: 'Monofett',
                color: Color.fromARGB(255, 255, 255, 255),
              ),
            ),
          ],
        ),
      ),
    ],
  ),
); }
  }

