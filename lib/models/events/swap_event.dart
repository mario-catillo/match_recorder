import 'package:match_recorder/enums/descriptors.dart';
import 'package:match_recorder/models/events/base_event.dart';
import 'package:match_recorder/models/player.dart';

class SwapEvent extends BaseEvent {
  SwapEvent({required Duration duration})
      : super(duration: duration, name: 'Swap');

  Player? player1;
  Player? player2;

  @override
  List<Descriptors> getDescriptors() {
    return [];
  }

  @override
  String getEventName() {
    return 'Swap';
  }

  @override
  Map<String, Player?> getPlayers() {
    return {'player out': player1, 'player in': player2};
  }

  @override
  Player? getPlayer(String key) {
    switch (key) {
      case 'player out':
        return player1;
      case 'player in':
        return player2;
      default:
        return null;
    }
  }

  @override
  void setPlayer(String key, Player? value) {
    print(key);
    if (key == 'player out') {
      player1 = value;
    }
    if (key == 'player in') {
      player2 = value;
    }
  }

  @override
  T? getDescriptorValue<T>() {
    return null;
  }

  @override
  setDescriptorValue<T>(T value) {}

  SwapEvent.fromJson(String json) : super.fromJson(json);
}
