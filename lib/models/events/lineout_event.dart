import 'package:match_recorder/enums/descriptors.dart';
import 'package:match_recorder/models/events/base_event.dart';

class LineoutEvent extends BaseEvent {
  final String quantity;

  LineoutEvent(this.quantity, {required String time})
      : super(name: 'Lineout', time: time);
  LineResult lineResult = LineResult.clean;
  LineQuantity lineQuantity = LineQuantity.seven;
  LinePosition lineoutPosition = LinePosition.A;

  @override
  String getEventName() => 'Lineout';

  @override
  List<Descriptors> getDescriptors() {
    return [
      Descriptors.lineResult,
      Descriptors.lineQuantity,
      Descriptors.linePosition
    ];
  }

  @override
  T getDescriptorValue<T>() {
    if (T == LineResult) {
      return lineResult as T;
    }
    if (T == LineQuantity) {
      return lineQuantity as T;
    }
    if (T == LinePosition) {
      return lineoutPosition as T;
    }
    throw UnimplementedError();
  }

  @override
  setDescriptorValue<T>(T value) {
    if (T == LineResult) {
      lineResult = value as LineResult;
    }
    if (T == LineQuantity) {
      lineQuantity = value as LineQuantity;
    }
    if (T == LinePosition) {
      lineoutPosition = value as LinePosition;
    }
  }
}
//Time;Team;Player(Catch);Player(Throw);Lineposition;Quantity;Zone;Lineresult;Linename
