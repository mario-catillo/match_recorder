import 'package:flutter/material.dart';
import 'package:match_recorder/models/app_state.dart';
import 'package:provider/provider.dart';

class LoadMatchDialog extends StatelessWidget {
  const LoadMatchDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future<List<String>> matches = context.read<AppState>().getSavedMatches();
    return AlertDialog(
      title: const Text('Load Match'),
      content: SizedBox(
        width: double.maxFinite,
        child: FutureBuilder(
          future: matches,
          builder: (ctx, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                shrinkWrap: true,
                itemBuilder: (ctx, index) {
                  return ListTile(
                    title: Text(snapshot.data![index]),
                    onTap: () {
                      context
                          .read<AppState>()
                          .loadMatchFromFile(snapshot.data![index]);
                      Navigator.of(context).pop(snapshot.data![index]);
                    },
                  );
                },
                itemCount: snapshot.data!.length,
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: const Text('No'),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, true),
          child: const Text('Yes'),
        ),
      ],
    );
  }
}
