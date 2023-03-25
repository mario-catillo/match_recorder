import 'package:match_recorder/models/base_event.dart';

class TackleEvent extends BaseEvent {
  TackleEvent({required String time}) : super(name: 'Tackle', time: time);

  @override
  String getEventName() => 'Tackle';
}
//Time;Team;Player;Shoulder;Progress