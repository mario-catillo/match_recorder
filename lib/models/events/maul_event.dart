import 'package:match_recorder/enums/descriptors.dart';
import 'package:match_recorder/models/events/base_event.dart';
import 'package:match_recorder/models/player.dart';
// import 'package:match_recorder/team_page.dart';

class MaulEvent extends BaseEvent {
  // TeamType winnerTeam;
  MovementProgression progress = MovementProgression.negative;
  MaulEvent({
    required Duration duration,
  }) : super(name: 'Maul', duration: duration);

  @override
  String getEventName() => 'Maul';

  @override
  List<Descriptors> getDescriptors() {
    return [Descriptors.movementProgression];
  }

  @override
  T? getDescriptorValue<T>() {
    if (T == MovementProgression) {
      return progress as T;
    }

    return null;
  }

  @override
  setDescriptorValue<T>(T value) {
    if (T == MovementProgression) {
      progress = value as MovementProgression;
    }
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

  MaulEvent.fromJson(String json) : super.fromJson(json);
}
