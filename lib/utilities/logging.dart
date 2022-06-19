class Logger {
  static const int DEBUG = 10;
  static const int INFO = 20;
  static const int WARNING = 30;
  static const int ERROR = 40;
  static const int CRITICAL = 50;

  static const Map<int, String> logLevels = {
    DEBUG: "DEBUG",
    INFO: "INFO",
    WARNING: "WARNING",
    ERROR: "ERROR",
    CRITICAL: "CRITICAL",
  };

  static int _logLevel = WARNING;
  static Set<String> _blacklist = Set();

  final String? name;

  Logger([this.name]);

  static assertValidLogLevel(int logLevel) {
    if (!logLevels.containsKey(logLevel)) {
      throw ArgumentError("Log level must be one of: $logLevels but '$logLevel' used.");
    }
  }

  static set logLevel(int newLogLevel) {
    assertValidLogLevel(newLogLevel);
    _logLevel = newLogLevel;
  }

  static set blacklist(Set<String> newBlacklist) {
    _blacklist = newBlacklist ?? Set();
  }

  log(int logLevel, dynamic message) {
    DateTime datetime = DateTime.now();
    assertValidLogLevel(logLevel);
    if (logLevel < _logLevel || (name != null && _blacklist.contains(name))) return;

    String output = ((message is Function) ? message() : message).toString();
    String logName = (name == null) ? "" : "($name) ";
    String duration = (this is _TimingLogger) ? " in ${datetime.difference((this as _TimingLogger).start)}" : "";

    print("$datetime $logName[${logLevels[logLevel]}]: $output$duration");
  }

  debug(dynamic message) {
    log(DEBUG, message);
  }

  info(dynamic message) {
    log(INFO, message);
  }

  warning(dynamic message) {
    log(WARNING, message);
  }

  error(dynamic message) {
    log(ERROR, message);
  }

  critical(dynamic message) {
    log(CRITICAL, message);
  }

  // Logs only when condition evaluated to true.
  Logger when(bool condition) {
    return (condition) ? this : _disabledLogger;
  }

  Logger time(DateTime start) {
    return _TimingLogger(start, name);
  }

  Logger subLogger(String name) {
    return (name == null) ? this : Logger("${this.name}.$name");
  }
}

final _disabledLogger = _DisabledLogger();

class _DisabledLogger extends Logger {
  @override
  log(int logLevel, message) {
    return;
  }
}

class _TimingLogger extends Logger {
  final DateTime start;

  _TimingLogger(this.start, name) : super(name);
}