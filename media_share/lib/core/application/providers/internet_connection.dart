
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:universal_html/html.dart';

part 'internet_connection.g.dart';

@riverpod
class InternetConnection extends _$InternetConnection {
  @override
  Stream<bool> build() {
    if(kIsWeb){
      return Stream.periodic(Duration(seconds: 1), (x) => window.navigator.onLine??true);
    }
   return Connectivity().onConnectivityChanged.map((ConnectivityResult result) => result != ConnectivityResult.none);
  }
}
