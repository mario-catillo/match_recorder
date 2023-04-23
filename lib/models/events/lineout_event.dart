import 'package:match_recorder/enums/descriptors.dart';
import 'package:match_recorder/models/app_state.dart';
import 'package:match_recorder/models/events/base_event.dart';
import 'package:match_recorder/models/player.dart';

class LineoutEvent extends BaseEvent {
  final String quantity;
  AppState? appState;

  LineoutEvent(this.quantity, {required Duration duration})
      : super(name: 'Lineout', duration: duration);

  LineResult lineResult = LineResult.clean;
  LineQuantity lineQuantity = LineQuantity.seven;
  LinePosition lineoutPosition = LinePosition.A;

  Player? receiver;
  Player? thrower;

  void setDefaultThrower(Player? player) {
    thrower = player;
  }

  void setAppState(AppState? state) {
    appState = state;
  }

  @override
  String getEventName() => 'Lineout';

  @override
  List<Descriptors> getDescriptors() {
    return [
      Descriptors.lineResult,
      Descriptors.lineQuantity,
      Descriptors.linePosition
    ];
  }

  @override
  T? getDescriptorValue<T>() {
    if (T == LineResult) {
      return lineResult as T;
    }
    if (T == LineQuantity) {
      return lineQuantity as T;
    }
    if (T == LinePosition) {
      return lineoutPosition as T;
    }
    return null;
  }

  @override
  setDescriptorValue<T>(T value) {
    if (T == LineResult) {
      lineResult = value as LineResult;
    }
    if (T == LineQuantity) {
      lineQuantity = value as LineQuantity;
    }
    if (T == LinePosition) {
      lineoutPosition = value as LinePosition;
    }
  }

  @override
  Map<String, Player?> getPlayers() {
    return {'receiver': receiver, 'thrower': thrower};
  }

  @override
  void setPlayer(String key, Player? value) {
    if (key == 'thrower') {
      thrower = value;
      appState?.defaultThrower = value;
    }
    if (key == 'receiver') {
      receiver = value;
    }
  }

  @override
  Player? getPlayer(String key) {
    if (key == 'thrower') {
      return thrower;
    }
    if (key == 'receiver') {
      return receiver;
    }
    return null;
  }
}
//Time;Team;Player(Catch);Player(Throw);Lineposition;Quantity;Zone;Lineresult;Linename
