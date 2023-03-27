import 'package:flutter/material.dart';
import 'package:match_recorder/models/app_state.dart';
import 'package:match_recorder/models/player.dart';
import 'package:match_recorder/models/team.dart';
import 'package:match_recorder/team_page.dart';
import 'package:provider/provider.dart';
import 'dart:math' as math;

class PlayerSelect extends StatelessWidget {
  final TeamType teamType;
  final Player? selectedPlayer;
  final String hintText;
  final void Function(Player player) onPlayerChanged;

  PlayerSelect({
    required this.teamType,
    required this.onPlayerChanged,
    required this.hintText,
    this.selectedPlayer,
  });

  @override
  Widget build(BuildContext context) {
    Team team = context.read<AppState>().getTeam(teamType);
    return Row(
      children: [
        Text(hintText),
        TextButton(
          child: Text(selectedPlayer?.name ?? 'Select'),
          onPressed: () => showDialog(
              context: context,
              builder: (ctx) => _PlayerSelectDialog(
                    players: team.players,
                    onPlayerTap: (player) {
                      onPlayerChanged(player);
                      Navigator.of(ctx).pop();
                    },
                  )),
        )
      ],
    );
  }
}

class _PlayerSelectDialog extends StatelessWidget {
  final List<Player> players;
  final Function(Player player) onPlayerTap;
  _PlayerSelectDialog({required this.players, required this.onPlayerTap});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return GestureDetector(
            child: SizedBox(
              width: constraints.maxWidth,
              height: constraints.maxWidth,
              child: CustomPaint(
                painter: _PlayerSelectPainter(
                    players: players, onPlayerTap: onPlayerTap),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _PlayerSelectPainter extends CustomPainter {
  final Paint _playerPaint = Paint()..color = Colors.blue;
  final List<Player> players;
  final Paint _backgroundPaint = Paint()..color = Colors.green;
  final Map<Player, Offset> _playerPositions = {};
  late Size savedSize;
  final Function(Player player) onPlayerTap;

  final TextPainter _textPainter = TextPainter(
    textAlign: TextAlign.center,
    textDirection: TextDirection.ltr,
  );
  _PlayerSelectPainter({required this.players, required this.onPlayerTap});

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
        row = 11;
        col = 6;
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
    double rowSize = (size.height / 12);
    double colSize = (size.width / 12);

    //calculate offset based on imaginary grid
    Offset position = Offset((rowSize * (_getGridPosition(player)['col'] ?? 0)),
        (colSize * (_getGridPosition(player)['row'] ?? 0)));

    _playerPositions[player] = position;
    _playerPaint.color = Colors.blue;
    canvas.drawCircle(position, rowSize * 0.8, _playerPaint);

    _textPainter.text = TextSpan(
      text: player.number,
      style: TextStyle(fontSize: 12, color: Colors.white),
    );
    _textPainter.layout();
    _textPainter.paint(
      canvas,
      Offset(position.dx - (_textPainter.width / 2),
          position.dy - (_textPainter.height / 2)),
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
