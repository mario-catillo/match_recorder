import 'package:match_recorder/models/base_event.dart';
import 'package:match_recorder/team_page.dart';

class ScrumEvent extends BaseEvent {
  TeamType winnerTeam;
  ScrumEvent({required String time, required this.winnerTeam})
      : super(name: 'Scrum', time: time);

  @override
  String getEventName() => 'Scrum';
}
