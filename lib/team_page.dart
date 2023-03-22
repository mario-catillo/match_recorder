import 'package:flutter/material.dart';
import 'package:match_recorder/models/app_state.dart';
import 'package:match_recorder/models/player.dart';
import 'package:match_recorder/models/team.dart';
import 'package:provider/provider.dart';

class TeamPage extends StatelessWidget {
  final Team team;
  const TeamPage({Key? key, required this.team}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(team.name),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              showDialog(context: context, builder: (ctx) => AddPlayerDialog());
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
  const AddPlayerDialog({Key? key}) : super(key: key);

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
            Provider.of<AppState>(context, listen: false).addPlayer(player);
            Navigator.of(context).pop();
          },
          child: const Text('Add'),
        ),
      ],
    );
  }
}
