import 'package:flutter/material.dart';
import 'package:match_recorder/models/player.dart';

class PlayerSelect extends StatelessWidget {
  final List<Player> players;
  final List<Player> alreadySelectedPlayers;
  final Function(Player player) onPlayerTap;
  final Player? selectedPlayer;
  const PlayerSelect(
      {super.key,
      required this.players,
      required this.onPlayerTap,
      required this.alreadySelectedPlayers,
      this.selectedPlayer});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return GestureDetector(
          child: SizedBox(
            width: constraints.maxWidth,
            height: constraints.maxWidth * 0.55,
            child: CustomPaint(
              painter: _PlayerSelectPainter(
                  players: players,
                  onPlayerTap: onPlayerTap,
                  alreadySelectedPlayers: alreadySelectedPlayers,
                  selectedPlayer: selectedPlayer),
            ),
          ),
        );
      },
    );
  }
}

class _PlayerSelectPainter extends CustomPainter {
  final Paint _playerPaint = Paint()..color = Colors.blue;
  final List<Player> players;
  final List<Player> alreadySelectedPlayers;
  final Player? selectedPlayer;
  final Paint _backgroundPaint = Paint()..color = Colors.green;
  final Map<Player, Offset> _playerPositions = {};
  late Size savedSize;
  final Function(Player player) onPlayerTap;

  final TextPainter _textPainter = TextPainter(
    textAlign: TextAlign.center,
    textDirection: TextDirection.ltr,
  );
  _PlayerSelectPainter(
      {required this.players,
      required this.onPlayerTap,
      this.selectedPlayer,
      required this.alreadySelectedPlayers});

  @override
  void paint(Canvas canvas, Size size) {
    savedSize = size;
    canvas.drawRect(Offset.zero & size, _backgroundPaint);
    for (Player player in players) {
      _drawPlayer(canvas, size, player);
    }
  }

  @override
  bool hitTest(Offset position) {
    for (MapEntry<Player, Offset> playerPosition in _playerPositions.entries) {
      final distance = (position - playerPosition.value).distance;

      if (distance <= savedSize.width / 12) {
        onPlayerTap(playerPosition.key);
        return true;
      }
    }
    return false;
  }

  Map<String, int> _getGridPosition(Player player) {
    int row = 0;
    int col = 0;
    switch (player.number) {
      case "1":
        row = 1;
        col = 2;
        break;
      case "2":
        row = 1;
        col = 6;
        break;
      case "3":
        row = 1;
        col = 10;
        break;
      case "4":
        row = 2;
        col = 4;
        break;
      case "5":
        row = 2;
        col = 8;
        break;
      case "6":
        row = 3;
        col = 1;
        break;
      case "7":
        row = 3;
        col = 11;
        break;
      case "8":
        row = 3;
        col = 6;
        break;
      case "9":
        row = 5;
        col = 4;
        break;
      case "10":
        row = 5;
        col = 8;
        break;
      case "11":
        row = 7;
        col = 1;
        break;
      case "12":
        row = 7;
        col = 5;
        break;
      case "13":
        row = 7;
        col = 7;
        break;
      case "14":
        row = 7;
        col = 11;
        break;
      case "15":
        row = 9;
        col = 6;
        break;
      case "16":
        row = 11;
        col = 1;
        break;
      case "17":
        row = 11;
        col = 2;
        break;
      case "18":
        row = 11;
        col = 3;
        break;
      case "19":
        row = 11;
        col = 4;
        break;
      case "20":
        row = 11;
        col = 5;
        break;
      case "21":
        row = 11;
        col = 6;
        break;
      case "22":
        row = 11;
        col = 7;
        break;
      default:
        row = -1;
        col = -1;
        print('Invalid player number');
        break;
    }
    return {'row': row, 'col': col};
  }

  void _drawPlayer(Canvas canvas, Size size, Player player) {
    bool selected = player.number == selectedPlayer?.number;
    double rowSize = (size.width / 12);
    double colSize = (size.height / 12);

    //calculate offset based on imaginary grid
    Offset position = Offset((rowSize * (_getGridPosition(player)['col'] ?? 0)),
        (colSize * (_getGridPosition(player)['row'] ?? 0)));

    _playerPositions[player] = position;

    bool isAlreadySelected = alreadySelectedPlayers
        .where((selectedPlayer) => selectedPlayer.number == player.number)
        .isNotEmpty;

    _playerPaint.color = selected
        ? Colors.red
        : isAlreadySelected
            ? Colors.yellow.shade800
            : Colors.blue;
    canvas.drawCircle(position, colSize * (selected ? 1 : 0.8), _playerPaint);

    _textPainter.text = TextSpan(
      text: player.number,
      style: const TextStyle(fontSize: 12, color: Colors.white),
    );

    _textPainter.layout();
    _textPainter.paint(
      canvas,
      Offset(position.dx - (_textPainter.width / 2),
          position.dy - (_textPainter.height / 2)),
    );

    _textPainter.text = TextSpan(
      text: player.name,
      style: TextStyle(fontSize: 6, color: Colors.white),
    );

    _textPainter.layout();
    _textPainter.paint(
      canvas,
      Offset(position.dx - (_textPainter.width / 2),
          position.dy - (_textPainter.height / 2) + 10),
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
