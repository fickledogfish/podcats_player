import 'dart:async' as async;

typedef DebouncerCallback = void Function();

class Debouncer {
  final Duration _delay;
  async.Timer? _timer;

  Debouncer({
    required Duration delay,
  }) : _delay = delay;

  run(DebouncerCallback callback) {
    _timer?.cancel();
    _timer = async.Timer(_delay, callback);
  }

  cancel() => _timer?.cancel();
}
