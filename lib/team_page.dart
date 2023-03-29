import 'package:flutter/material.dart';
import 'package:match_recorder/models/app_state.dart';
import 'package:match_recorder/models/player.dart';
import 'package:match_recorder/widgets/teams/team_open_dialog.dart';
import 'package:match_recorder/widgets/teams/team_save_dialog.dart';
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
              onPressed: () => showDialog(
                  context: context,
                  builder: (ctx) => TeamOpenDialog(
                        teamType: teamType,
                      )),
              icon: const Icon(Icons.folder_open_outlined)),
          IconButton(
              onPressed: () => showDialog(
                  context: context,
                  builder: (ctx) => TeamSaveDialog(team: team)),
              icon: const Icon(Icons.save)),
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
          itemCount: appstate.getTeam(teamType).players.length,
          itemBuilder: (ctx, index) {
            List<Player> playersCopy = List.from(
                appstate.getTeam(teamType).players
                  ..sort((p1, p2) =>
                      int.parse(p1.number).compareTo(int.parse(p2.number))));
            Player player = playersCopy[index];
            return ListTile(
              onLongPress: () => appstate.setTeam(
                  team
                    ..players.removeWhere(
                        (element) => element.number == player.number),
                  teamType),
              title: Text(player.name),
              subtitle: Text(player.number.toString()),
            );
          },
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
