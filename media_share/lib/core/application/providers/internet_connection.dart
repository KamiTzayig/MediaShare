import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'internet_connection.g.dart';

@riverpod
class InternetConnection extends _$InternetConnection {
  @override
  Stream<bool> build() => Connectivity()
      .onConnectivityChanged
      .map((ConnectivityResult result) => result != ConnectivityResult.none);
}
