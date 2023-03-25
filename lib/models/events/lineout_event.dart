import 'package:match_recorder/enums/descriptors.dart';
import 'package:match_recorder/models/events/base_event.dart';

class LineoutEvent extends BaseEvent {
  final String quantity;

  LineoutEvent(this.quantity, {required String time})
      : super(name: 'Lineout', time: time);

  @override
  String getEventName() => 'Lineout';

  @override
  List<Descriptors> getDescriptors() {
    return [];
  }

  @override
  T getDescriptorValue<T>() => throw UnimplementedError();

  @override
  setDescriptorValue<T>(T value) => throw UnimplementedError();
}
//Time;Team;Player(Catch);Player(Throw);Lineposition;Quantity;Zone;Lineresult;Linename
