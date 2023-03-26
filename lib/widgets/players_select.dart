import 'package:flutter/material.dart';
import 'package:match_recorder/models/app_state.dart';
import 'package:match_recorder/models/player.dart';
import 'package:match_recorder/models/team.dart';
import 'package:match_recorder/team_page.dart';
import 'package:provider/provider.dart';

class PlayersSelect extends StatefulWidget {
  TeamType teamType;
  List<Player> selectedPlayers = [];
  final void Function(List<Player> players) onPlayersChanged;

  PlayersSelect({
    required this.teamType,
    required this.onPlayersChanged,
    this.selectedPlayers = const [],
  });

  @override
  _PlayersSelectState createState() => _PlayersSelectState();
}

class _PlayersSelectState extends State<PlayersSelect> {
  late List<Player> selectedPlayers;

  @override
  void initState() {
    selectedPlayers = widget.selectedPlayers;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Team team = context.read<AppState>().getTeam(widget.teamType);
    return ListView.builder(
      itemCount: team.players.length,
      itemBuilder: (ctx, index) => CheckboxListTile(
        title: Text(team.players[index].name),
        value: selectedPlayers.contains(team.players[index]),
        onChanged: (bool? value) {
          setState(() {
            if (value == true) {
              selectedPlayers.add(team.players[index]);
            } else {
              selectedPlayers.remove(team.players[index]);
            }
          });
          widget.onPlayersChanged(selectedPlayers);
        },
      ),
    );
  }
}
