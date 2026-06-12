import '../models/game_model.dart';

class GameService {
  static void makeMove(GameModel game, int index) {
    if (game.board[index].isEmpty &&
        game.winner.isEmpty) {
      game.board[index] = game.currentPlayer;

      checkWinner(game);

      if (game.winner.isEmpty) {
        game.currentPlayer =
            game.currentPlayer == 'X'
                ? 'O'
                : 'X';
      }
    }
  }

  static void checkWinner(GameModel game) {
    List<List<int>> patterns = [
      [0,1,2],
      [3,4,5],
      [6,7,8],
      [0,3,6],
      [1,4,7],
      [2,5,8],
      [0,4,8],
      [2,4,6],
    ];

    for (var p in patterns) {
      String a = game.board[p[0]];
      String b = game.board[p[1]];
      String c = game.board[p[2]];

      if (a.isNotEmpty && a == b && b == c) {
        game.winner = a;
        return;
      }
    }

    if (!game.board.contains('')) {
      game.winner = 'Draw';
    }
  }

  static void reset(GameModel game) {
    game.board = List.filled(9, '');
    game.currentPlayer = 'X';
    game.winner = '';
  }
}
