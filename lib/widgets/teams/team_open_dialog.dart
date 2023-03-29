import 'package:flutter/material.dart';
import 'package:match_recorder/models/app_state.dart';
import 'package:match_recorder/models/team.dart';
import 'package:match_recorder/team_page.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TeamOpenDialog extends StatefulWidget {
  final TeamType teamType;
  const TeamOpenDialog({Key? key, required this.teamType}) : super(key: key);

  @override
  State<TeamOpenDialog> createState() => _TeamOpenDialogState();
}

class _TeamOpenDialogState extends State<TeamOpenDialog> {
  List<String> savedTeams = [];
  late SharedPreferences prefs;

  void loadPrefs() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      savedTeams = prefs.getStringList('savedTeams') ?? [];
    });
  }

  @override
  void initState() {
    super.initState();
    loadPrefs();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Open Team'),
      content: Container(
        width: double.maxFinite,
        child: ListView.builder(
          shrinkWrap: true,
          itemBuilder: (ctx, index) {
            return ListTile(
              title: Text(savedTeams[index]),
              onTap: () {
                context.read<AppState>().setTeam(
                    Team.fromJson(
                        prefs.getString("team-${savedTeams[index]}") ?? ''),
                    widget.teamType);
                Navigator.of(context).pop(savedTeams[index]);
              },
            );
          },
          itemCount: savedTeams.length,
        ),
      ),
      actions: [],
    );
  }
}
