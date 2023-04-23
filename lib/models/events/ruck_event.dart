import 'package:match_recorder/enums/descriptors.dart';
import 'package:match_recorder/models/events/base_event.dart';
import 'package:match_recorder/models/player.dart';

class RuckEvent extends BaseEvent {
  RuckEvent({required Duration duration})
      : super(name: 'Ruck', duration: duration);
  Speed speed = Speed.slow;
  // MovementProgression progress = MovementProgression.neutral;

  @override
  String getEventName() => 'Ruck';

  @override
  List<Descriptors> getDescriptors() {
    return [Descriptors.speed];
  }

  @override
  T? getDescriptorValue<T>() {
    if (T == Speed) {
      return speed as T;
    }
    // if (T == MovementProgression) {
    //   return progress as T;
    // }
    return null;
  }

  @override
  setDescriptorValue<T>(T value) {
    if (T == Speed) {
      speed = value as Speed;
    }
    // if (T == MovementProgression) {
    //   progress = value as MovementProgression;
    // }
  }

  @override
  Map<String, Player?> getPlayers() {
    return {};
  }

  @override
  void setPlayer(String key, Player? value) {
    throw UnimplementedError();
  }

  @override
  Player? getPlayer(String key) {
    throw UnimplementedError();
  }
}
