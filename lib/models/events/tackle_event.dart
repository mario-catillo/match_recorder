import 'package:match_recorder/enums/descriptors.dart';
import 'package:match_recorder/models/events/base_event.dart';
import 'package:match_recorder/models/player.dart';
import 'package:match_recorder/widgets/descriptors/progression_descriptor.dart';

class TackleEvent extends BaseEvent {
  TackleEvent({required String time}) : super(name: 'Tackle', time: time);
  MovementProgression progress = MovementProgression.neutral;

  @override
  String getEventName() => 'Tackle';

  @override
  List<Descriptors> getDescriptors() {
    return [Descriptors.movementProgression];
  }

  @override
  T getDescriptorValue<T>() {
    if (T == MovementProgression) {
      return progress as T;
    }
    throw UnimplementedError();
  }

  @override
  setDescriptorValue<T>(T value) {
    if (T == MovementProgression) {
      progress = value as MovementProgression;
    }
  }
}
//Time;Team;Player;Shoulder;Progress