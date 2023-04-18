import 'package:flutter/cupertino.dart';
import 'package:match_recorder/enums/descriptors.dart';

class RestartTypenDescriptor extends StatelessWidget {
  final RestartType restartType;
  final Function(RestartType restartType) onrestartTypeChanged;
  const RestartTypenDescriptor(
      {Key? key, required this.restartType, required this.onrestartTypeChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoSlidingSegmentedControl<RestartType>(
      children: const {
        RestartType.kickoff: Text('Kick off'),
        RestartType.drop22: Text('Drop 22'),
        RestartType.dropingoal: Text('Drop Ingoal'),
      },
      onValueChanged: (RestartType? restartType) {
        if (restartType != null) {
          onrestartTypeChanged(restartType);
        }
      },
      groupValue: restartType,
    );
  }
}
