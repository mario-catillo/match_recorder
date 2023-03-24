import 'package:match_recorder/models/base_event.dart';

class LineoutEvent extends BaseEvent {
  final String quantity;

  LineoutEvent(this.quantity, {required String time})
      : super(name: 'Lineout', time: time);

  @override
  String getEventName() => 'Lineout';
}
//Time;Team;Player(Catch);Player(Throw);Lineposition;Quantity;Zone;Lineresult;Linename
