import 'package:flutter/material.dart';
import 'package:match_recorder/models/app_state.dart';
import 'package:match_recorder/models/player.dart';
import 'package:match_recorder/models/team.dart';
import 'package:provider/provider.dart';

enum TeamType { team1, team2 }

class TeamPage extends StatelessWidget {
  final TeamType teamType;
  const TeamPage({Key? key, required this.teamType}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final team = context.read<AppState>().getTeam(teamType);
    return Scaffold(
      appBar: AppBar(
        title: Text(team.name),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (ctx) => AddPlayerDialog(
                        teamType: teamType,
                      ));
            },
          ),
        ],
      ),
      body: Consumer<AppState>(
        builder: (ctx, appstate, child) => ListView.builder(
          itemCount: team.players.length,
          itemBuilder: (ctx, index) => Row(children: [
            Text(team.players[index].name),
            Text(team.players[index].number),
          ]),
        ),
      ),
    );
  }
}

class AddPlayerDialog extends StatefulWidget {
  final TeamType teamType;
  const AddPlayerDialog({Key? key, required this.teamType}) : super(key: key);

  @override
  _AddPlayerDialogState createState() => _AddPlayerDialogState();
}

class _AddPlayerDialogState extends State<AddPlayerDialog> {
  Player player = Player(name: '', number: '');

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add Player'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            decoration: const InputDecoration(
              labelText: 'Name',
            ),
            onChanged: (value) => player = Player(
              name: value,
              number: player.number,
            ),
          ),
          TextField(
            decoration: const InputDecoration(
              labelText: 'Number',
            ),
            onChanged: (value) => player = Player(
              name: player.name,
              number: value,
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            Provider.of<AppState>(context, listen: false)
                .addPlayer(player, widget.teamType);
            Navigator.of(context).pop();
          },
          child: const Text('Add'),
        ),
      ],
    );
  }
}
