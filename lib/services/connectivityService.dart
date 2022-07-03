import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityService{
  final _connevity = Connectivity();
  final connectitvityStream = StreamController<ConnectivityResult>();

  ConnectivityService(){
    _connevity.onConnectivityChanged.listen((event) {
      connectitvityStream.add(event);
    });
  }

}