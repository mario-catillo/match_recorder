import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:match_recorder/models/team.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TeamSaveDialog extends StatefulWidget {
  final Team team;
  const TeamSaveDialog({Key? key, required this.team}) : super(key: key);

  @override
  State<TeamSaveDialog> createState() => _TeamSaveDialogState();
}

class _TeamSaveDialogState extends State<TeamSaveDialog> {
  late SharedPreferences prefs;

  void loadPrefs() async {
    prefs = await SharedPreferences.getInstance();
  }

  @override
  void initState() {
    loadPrefs();
    super.initState();
  }

  String teamName = '';
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Save Team'),
      content: Column(
        children: [
          TextField(
            onChanged: (value) {
              setState(() {
                teamName = value;
              });
            },
          ),
          const Text('Are you sure you want to save this team?'),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: const Text('No'),
        ),
        TextButton(
          onPressed: () {
            List<String> teamNames = prefs.getStringList('savedTeams') ?? [];
            if (!teamNames.contains(teamName)) {
              teamNames.add(teamName);
            }
            prefs.setStringList('savedTeams', teamNames);
            prefs.setString("team-$teamName", widget.team.toJson());
            Navigator.of(context).pop(true);
          },
          child: const Text('Yes'),
        ),
      ],
    );
  }
}
