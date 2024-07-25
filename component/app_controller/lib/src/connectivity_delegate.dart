import 'dart:async';

import 'package:core/core.dart';
import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:rxdart/rxdart.dart';
import 'package:td_api/td_api.dart' as td;

class ConnectivityDelegate {
  ConnectivityDelegate({
    required ITdFunctionExecutor functionExecutor,
    required IConnectivityProvider connectivityProvider,
  })  : _functionExecutor = functionExecutor,
        _connectivityProvider = connectivityProvider;

  final ITdFunctionExecutor _functionExecutor;
  final IConnectivityProvider _connectivityProvider;

  StreamSubscription<dynamic>? _connectivitySubscription;

  void onInit() {
    _connectivitySubscription = _connectivityProvider.onStatusChange
        .startWith(_connectivityProvider.status)
        .distinct()
        .listen((ConnectivityStatus status) {
      _functionExecutor.send(td.SetNetworkType(type: status.toNetworkType()));
      // _functionExecutor.send(const td.SetNetworkType(type: td.NetworkTypeNone()));
    });
  }

  void dispose() {
    _connectivitySubscription?.cancel();
  }
}
