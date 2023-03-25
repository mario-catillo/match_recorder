import 'package:match_recorder/enums/descriptors.dart';
import 'package:match_recorder/models/events/base_event.dart';

class RuckEvent extends BaseEvent {
  RuckEvent({required String time}) : super(name: 'Ruck', time: time);
  Speed speed = Speed.slow;
  MovementProgression progress = MovementProgression.neutral;

  @override
  String getEventName() => 'Ruck';

  @override
  List<Descriptors> getDescriptors() {
    return [Descriptors.speed, Descriptors.movementProgression];
  }

  @override
  T getDescriptorValue<T>() {
    if (T == Speed) {
      return speed as T;
    }
    if (T == MovementProgression) {
      return progress as T;
    }
    throw UnimplementedError();
  }

  @override
  setDescriptorValue<T>(T value) {
    if (T == Speed) {
      speed = value as Speed;
    }
    if (T == MovementProgression) {
      progress = value as MovementProgression;
    }
  }
}
