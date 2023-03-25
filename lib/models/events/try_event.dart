import 'package:match_recorder/enums/descriptors.dart';
import 'package:match_recorder/models/events/base_event.dart';

class TryEvent extends BaseEvent {
  TryEvent({required String time}) : super(name: 'Try', time: time);

  @override
  String getEventName() => 'Try';

  @override
  List<Descriptors> getDescriptors() {
    return [];
  }

  @override
  T getDescriptorValue<T>() => throw UnimplementedError();

  @override
  setDescriptorValue<T>(T value) => throw UnimplementedError();
}
