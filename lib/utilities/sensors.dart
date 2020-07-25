import 'package:act_draw_explain/utilities/logging.dart';
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
  return _inRange(value, -1, 1);
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
  final _logMovement = Logger("TiltEvent.movement");
  final _logOther = Logger("TiltEvent.other");

  TiltEvent(this.acc, this.gyro);

  TiltDirection get direction {
    TiltDirection tilt;

    List<int> gyroMoving = [_noChange(gyro.x), _inRange(gyro.y.abs(), 2, _MAX_VAL), _noChange(gyro.z)];

    int downMovement = _inRange(acc.z, _MIN_VAL, -8);
    int upMovement = _inRange(acc.z, 7, _MAX_VAL);

    if (all(gyroMoving)) {
      if (downMovement == 1) {
        tilt = TiltDirection.down;
      } else if (upMovement == 1) {
        tilt = TiltDirection.up;
      }
    }

    ((gyroMoving[2] == 0) ? _logMovement : _logOther).debug(() {
      var gyroMoveDebug = sprintf(MOVEMENT_TEMPLATE, gyroMoving);
      var accDebug = sprintf(SENSOR_TEMPLATE, [acc.x, acc.y, acc.z]);
      var gyroDebug = sprintf(SENSOR_TEMPLATE, [gyro.x, gyro.y, gyro.z]);

      return "Gyro: $gyroMoveDebug | Down: $downMovement | Up: $upMovement | Acc $accDebug | Gyro $gyroDebug | $tilt";
    });

    return tilt;
  }
}

Logger _log = Logger("TiltEvent.detection");

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
        _log.info("########## ${tilt?.direction} ############");
      }
    });
