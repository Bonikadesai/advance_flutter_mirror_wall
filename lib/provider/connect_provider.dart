import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mirror_wall/model/models.dart';

class ConnectProvider extends ChangeNotifier {
  Connectivity connectivity = Connectivity();
  ConnectModel connectModel = ConnectModel(connectStatus: "Waiting");

  void checkInternet() {
    connectModel.connectStream = connectivity.onConnectivityChanged
        .listen((ConnectivityResult connectivityResult) {
      switch (connectivityResult) {
        case ConnectivityResult.mobile:
          connectModel.connectStatus = "Mobile";
          notifyListeners();
          break;

        case ConnectivityResult.wifi:
          connectModel.connectStatus = "Wifi";
          notifyListeners();
          break;

        default:
          connectModel.connectStatus = "Waiting";
      }
    });
  }
}
