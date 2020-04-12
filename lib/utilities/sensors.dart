import 'package:sensors/sensors.dart';
import 'package:sprintf/sprintf.dart';

import 'package:stream_transform/stream_transform.dart';

import '../constants.dart';

const _MAX_VAL = double.maxFinite;
const _MIN_VAL = double.maxFinite * -1;

int _inRange(value, low, high) {
  return (value >= low && value <= high).toInt();
}

int _noChange(value) {
  return _inRange(value, -1.5, 1.5);
}

extension ConversionsToInt on bool {
  int toInt() {
    return (this) ? 1 : 0;
  }
}

bool all(List list) {
  for (var i = 0; i < list.length; i++) {
    if (list[i] == 0) {
      return false;
    }
  }
  return true;
}

enum TiltDirection { up, down }

class TiltEvent {
  static const String MOVEMENT_TEMPLATE = "%s %s %s";
  static const String SENSOR_TEMPLATE = "X: %.1f, Y: %.1f, Z: %.1f";

  final AccelerometerEvent acc;
  final GyroscopeEvent gyro;

  TiltEvent(this.acc, this.gyro);

  TiltDirection get direction {
    TiltDirection tilt;

    List<int> gyroMoving = [
      _noChange(gyro.x),
      _inRange(gyro.y.abs(), 2, _MAX_VAL),
      _noChange(gyro.z)
    ];

    List<int> downMovement = [
      _inRange(acc.x, -4, 4),
      _noChange(acc.y),
      _inRange(acc.z, _MIN_VAL, -9),
    ];

    List<int> upMovement = [
      _inRange(acc.x, -4, 4),
      _noChange(acc.y),
      _inRange(acc.z, 7.5, _MAX_VAL),
    ];

    if (all(gyroMoving)) {
      if (all(downMovement)) {
        tilt = TiltDirection.down;
      } else if (all(upMovement)) {
        tilt = TiltDirection.up;
      }
    }

    debugSensors(acc, gyro, gyroMoving, downMovement, upMovement, tilt);
    return tilt;
  }

  void debugTilt() {}

  void debugSensors(
    AccelerometerEvent _acc,
    GyroscopeEvent _gyro,
    List<int> gyroMoving,
    List<int> downMovement,
    List<int> upMovement,
    TiltDirection tilt,
  ) {
    if (K_DEBUG_TILT_SENSORS == DebugLevel.none) {
      return;
    }

    if (K_DEBUG_TILT_SENSORS == DebugLevel.movement && gyroMoving[2] == 0) {
      return;
    }

    var gyroMoveDebug = sprintf(MOVEMENT_TEMPLATE, gyroMoving);
    var downDebug = sprintf(MOVEMENT_TEMPLATE, downMovement);
    var upDebug = sprintf(MOVEMENT_TEMPLATE, upMovement);
    var accDebug = sprintf(SENSOR_TEMPLATE, [_acc.x, _acc.y, _acc.z]);
    var gyroDebug = sprintf(SENSOR_TEMPLATE, [_gyro.x, _gyro.y, _gyro.z]);

    print("Gyro: $gyroMoveDebug | Down: $downDebug | Up: $upDebug | Acc $accDebug | Gyro $gyroDebug | $tilt");
  }
}

Stream<TiltEvent> tiltStream = accelerometerEvents
    .throttle(K_SENSORS_THROTTLE)
    .where((event) => event != null)
    .combineLatest(
      gyroscopeEvents.throttle(K_SENSORS_THROTTLE).where((event) => event != null),
      (AccelerometerEvent accelEvent, GyroscopeEvent gyroEvent) {
        var tilt = TiltEvent(accelEvent, gyroEvent);
        return (tilt.direction == null) ? null : tilt;
      },
    )
    .where((tilt) => tilt != null)
    .throttle(K_TILT_THROTTLE)
    .tap((tilt) {
      if (K_DEBUG_TILT_SENSORS != DebugLevel.none) {
        print("########## EVENT ${tilt?.direction} ############");
      }
    });
