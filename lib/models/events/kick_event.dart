import 'package:match_recorder/enums/descriptors.dart';
import 'package:match_recorder/models/events/base_event.dart';

class KickEvent extends BaseEvent {
  KickEvent({required String time}) : super(name: 'Kick', time: time);
  KickType kickType = KickType.upAndUnder;
  @override
  String getEventName() => 'Kick';

  @override
  List<Descriptors> getDescriptors() {
    return [Descriptors.kickType];
  }

  @override
  T getDescriptorValue<T>() {
    if (T == KickType) {
      return kickType as T;
    }
    throw UnimplementedError();
  }

  @override
  setDescriptorValue<T>(T value) {
    if (T == KickType) {
      kickType = value as KickType;
    }
  }
}
