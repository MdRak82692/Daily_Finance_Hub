// ignore_for_file: file_names

import 'dart:async';

Timer? _timer;

void startAutoRefresh(Future<String> Function() fetchData) {
  _timer = Timer.periodic(const Duration(microseconds: 1), (timer) {
    fetchData();
  });
}

void stopAutoRefresh() {
  if (_timer != null) {
    _timer!.cancel();
  }
}
