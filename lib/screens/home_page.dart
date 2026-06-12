import 'package:flutter/material.dart';

import '../models/game_model.dart';
import '../services/game_service.dart';
import '../widgets/game_cell.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GameModel game = GameModel();
  
  // Real-time scoreboard variables
  int xScore = 0;
  int oScore = 0;
  int draws = 0;

  void _makeMove(int index) {
    if (game.board[index].isEmpty && game.winner.isEmpty) {
      setState(() {
        GameService.makeMove(game, index);
        // Update score when game completes
        if (game.winner == 'X') {
          xScore++;
        } else if (game.winner == 'O') {
          oScore++;
        } else if (game.winner == 'Draw') {
          draws++;
        }
      });
    }
  }

  Widget _buildScoreColumn(String label, int score, Color color) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.white.withOpacity(0.5),
            fontSize: 12,
            fontWeight: FontWeight.w600,
            letterSpacing: 1.5,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          score.toString(),
          style: TextStyle(
            color: color,
            fontSize: 26,
            fontWeight: FontWeight.w900,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    String status;

    if (game.winner.isEmpty) {
      status = 'Player ${game.currentPlayer}\'s Turn';
    } else if (game.winner == 'Draw') {
      status = 'Game Draw!';
    } else {
      status = 'Winner: Player ${game.winner}';
    }

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF0B0F19), // Deep rich dark blue-gray
              Color(0xFF05070C), // Pure dark space
              Color(0xFF131024), // Subtle deep violet
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
            child: Column(
              children: [
                const SizedBox(height: 10),
                
                // Neon Title Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "TIC ",
                      style: TextStyle(
                        color: Colors.blue.shade400,
                        fontSize: 32,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 2,
                      ),
                    ),
                    const Text(
                      "TAC ",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 2,
                      ),
                    ),
                    Text(
                      "TOE",
                      style: TextStyle(
                        color: Colors.pink.shade400,
                        fontSize: 32,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 2,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                // Frosted Glass Scoreboard
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 12),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.03),
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.06),
                      width: 1.5,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildScoreColumn("PLAYER X", xScore, Colors.blue.shade400),
                      Container(height: 30, width: 1, color: Colors.white.withOpacity(0.1)),
                      _buildScoreColumn("DRAWS", draws, Colors.grey.shade400),
                      Container(height: 30, width: 1, color: Colors.white.withOpacity(0.1)),
                      _buildScoreColumn("PLAYER O", oScore, Colors.pink.shade400),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // Status Banner
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 28),
                  decoration: BoxDecoration(
                    color: game.winner.isEmpty
                        ? Colors.white.withOpacity(0.04)
                        : (game.winner == 'Draw'
                            ? Colors.grey.withOpacity(0.08)
                            : (game.winner == 'X' 
                                ? Colors.blue.withOpacity(0.12) 
                                : Colors.pink.withOpacity(0.12))),
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(
                      color: game.winner.isEmpty
                          ? Colors.white.withOpacity(0.08)
                          : (game.winner == 'Draw'
                              ? Colors.grey.withOpacity(0.25)
                              : (game.winner == 'X' 
                                  ? Colors.blue.shade400.withOpacity(0.4) 
                                  : Colors.pink.shade400.withOpacity(0.4))),
                      width: 1.5,
                    ),
                  ),
                  child: Text(
                    status.toUpperCase(),
                    style: TextStyle(
                      color: game.winner.isEmpty
                          ? Colors.white.withOpacity(0.9)
                          : (game.winner == 'Draw'
                              ? Colors.grey.shade300
                              : (game.winner == 'X' 
                                  ? Colors.blue.shade300 
                                  : Colors.pink.shade300)),
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5,
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                // Game Board Grid
                Expanded(
                  child: Center(
                    child: AspectRatio(
                      aspectRatio: 1.0,
                      child: GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: 9,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                        ),
                        itemBuilder: (context, index) {
                          return GameCell(
                            value: game.board[index],
                            onTap: () => _makeMove(index),
                          );
                        },
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // Action Buttons (Reset Board & Reset Scores)
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 56,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          gradient: const LinearGradient(
                            colors: [
                              Color(0xFF2563EB), // Vibrant blue
                              Color(0xFFDB2777), // Vibrant pink
                            ],
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFFDB2777).withOpacity(0.25),
                              blurRadius: 15,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          onPressed: () {
                            setState(() {
                              GameService.reset(game);
                            });
                          },
                          child: const Text(
                            "RESET BOARD",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.5,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    IconButton(
                      style: IconButton.styleFrom(
                        backgroundColor: Colors.white.withOpacity(0.04),
                        padding: const EdgeInsets.all(16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          side: BorderSide(
                            color: Colors.white.withOpacity(0.08),
                            width: 1.5,
                          ),
                        ),
                      ),
                      icon: const Icon(Icons.refresh, color: Colors.white),
                      onPressed: () {
                        setState(() {
                          GameService.reset(game);
                          xScore = 0;
                          oScore = 0;
                          draws = 0;
                        });
                      },
                    ),
                  ],
                ),

                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
