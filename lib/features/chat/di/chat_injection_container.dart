import 'package:flutter_hung_chatbot/features/chat/data/datasources/chat_local_data_source.dart';
import 'package:flutter_hung_chatbot/features/chat/data/datasources/chat_remote_data_source.dart';
import 'package:flutter_hung_chatbot/features/chat/data/repositories/chat_repository_impl.dart';
import 'package:flutter_hung_chatbot/features/chat/domain/repositories/chat_repository.dart';
import 'package:flutter_hung_chatbot/features/chat/domain/usecases/get_chat_history.dart';
import 'package:flutter_hung_chatbot/features/chat/domain/usecases/send_message.dart';
import 'package:flutter_hung_chatbot/features/chat/presentation/bloc/chat_bloc.dart';
import 'package:flutter_hung_chatbot/flavors.dart';
import 'package:get_it/get_it.dart';

/// Registers all dependencies related to the Chat feature
void registerChatDependencies(GetIt sl) {
  // Bloc
  sl.registerFactory(() => ChatBloc(sendMessage: sl(), getChatHistory: sl()));

  // Use cases
  sl.registerLazySingleton(() => SendMessage(sl()));
  sl.registerLazySingleton(() => GetChatHistory(sl()));

  // Repository
  sl.registerLazySingleton<ChatRepository>(
    () => ChatRepositoryImpl(remoteDataSource: sl(), localDataSource: sl(), networkInfo: sl()),
  );

  // Data sources
  sl.registerLazySingleton<ChatRemoteDataSource>(
    () => ChatRemoteDataSourceImpl(dio: sl(), apiKey: F.getApiKey),
  );
  sl.registerLazySingleton<ChatLocalDataSource>(() => ChatLocalDataSourceImpl(box: sl()));
}
