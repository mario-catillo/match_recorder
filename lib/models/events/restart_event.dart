import 'package:match_recorder/enums/descriptors.dart';
import 'package:match_recorder/models/events/base_event.dart';
import 'package:match_recorder/models/player.dart';
// import 'package:match_recorder/team_page.dart';

class RestartEvent extends BaseEvent {
  // TeamType winnerTeam;
  RestartType restartType = RestartType.kickoff;
  RestartEvent({
    required Duration duration,
  }) : super(name: 'Restart', duration: duration);

  @override
  String getEventName() => 'Restart';

  @override
  List<Descriptors> getDescriptors() {
    return [Descriptors.restartType];
  }

  @override
  T? getDescriptorValue<T>() {
    if (T == RestartType) {
      return restartType as T;
    }
    return null;
  }

  @override
  setDescriptorValue<T>(T value) {
    if (T == RestartType) {
      restartType = value as RestartType;
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
}
