import 'package:match_recorder/models/base_event.dart';

class TryEvent extends BaseEvent {
  TryEvent({required String time}) : super(name: 'Try', time: time);

  @override
  String getEventName() => 'Try';
}
