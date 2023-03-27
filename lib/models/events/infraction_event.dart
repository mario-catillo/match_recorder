import 'package:match_recorder/enums/descriptors.dart';
import 'package:match_recorder/models/events/base_event.dart';

class InfractionEvent extends BaseEvent {
  Infraction infraction = Infraction.dirtyPlay;
  InfractionEvent({required String time})
      : super(name: 'Infraction', time: time);

  @override
  String getEventName() => 'Infraction';

  @override
  List<Descriptors> getDescriptors() {
    return [Descriptors.infraction];
  }

  @override
  T getDescriptorValue<T>() {
    if (T == Infraction) {
      return infraction as T;
    }
    throw UnimplementedError();
  }

  @override
  setDescriptorValue<T>(T value) {
    if (T == Infraction) {
      infraction = value as Infraction;
    }
  }
}
