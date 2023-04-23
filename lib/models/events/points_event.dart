import 'package:match_recorder/enums/descriptors.dart';
import 'package:match_recorder/models/events/base_event.dart';
import 'package:match_recorder/models/player.dart';

class PointsEvent extends BaseEvent {
  PointsEvent({required Duration duration})
      : super(name: 'Points', duration: duration);
  Points points = Points.try5;
  Player? pointsPlayer;
  @override
  String getEventName() => 'Points';

  @override
  List<Descriptors> getDescriptors() {
    return [Descriptors.points];
  }

  @override
  T? getDescriptorValue<T>() {
    if (T == Points) {
      return points as T;
    }
    return null;
  }

  @override
  setDescriptorValue<T>(T value) {
    if (T == Points) {
      points = value as Points;
    }
  }

  @override
  Map<String, Player?> getPlayers() {
    return {'pointsPlayer': pointsPlayer};
  }

  @override
  void setPlayer(String key, Player? value) {
    if (key == 'pointsPlayer') {
      pointsPlayer = value;
    }
  }

  @override
  Player? getPlayer(String key) {
    if (key == 'pointsPlayer') {
      return pointsPlayer;
    }
    return null;
  }
}
