import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter_hung_chatbot/core/network/network_info.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';

/// Registers all core dependencies that are shared across features
void registerCoreDependencies(GetIt sl) {
  // Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  // External
  sl.registerLazySingleton(
    () => Dio(
      BaseOptions(
        headers: {'Content-Type': 'application/json'},
        connectTimeout: const Duration(minutes: 1),
        receiveTimeout: const Duration(minutes: 1),
      ),
    ),
  );
  sl.registerLazySingleton(() => Connectivity());
  sl.registerLazySingleton(() => Hive.box('myBox'));
}
