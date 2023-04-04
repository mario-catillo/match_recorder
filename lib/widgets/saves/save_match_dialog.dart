import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:match_recorder/models/app_state.dart';
import 'package:provider/provider.dart';

class SaveMatchDialog extends StatefulWidget {
  const SaveMatchDialog({Key? key}) : super(key: key);

  @override
  _SaveMatchDialogState createState() => _SaveMatchDialogState();
}

class _SaveMatchDialogState extends State<SaveMatchDialog> {
  String matchName = '';
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Save Match'),
      content: Column(
        children: [
          const Text('Do you want to save this match?'),
          TextField(
            onChanged: (value) => matchName = value,
            decoration: const InputDecoration(
              hintText: 'Match name',
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: const Text('No'),
        ),
        TextButton(
          onPressed: () async {
            await context.read<AppState>().saveMatchToFile(matchName);
            Navigator.pop(context, true);
          },
          child: const Text('Yes'),
        ),
      ],
    );
  }
}
