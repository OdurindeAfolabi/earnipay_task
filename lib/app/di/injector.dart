import 'package:dio/dio.dart';
import 'package:earnipay_task/app/utils/constants.dart';
import 'package:earnipay_task/data/remote/service/photo/photo_service.dart';
import 'package:earnipay_task/data/repository/photo_repository.dart';
import 'package:earnipay_task/domain/photo/get_photos_usecase.dart';
import 'package:earnipay_task/presentation/photos/photos_view_model.dart';
import 'package:get_it/get_it.dart';
import '../../data/local/data_local_source.dart';
import '../../data/remote/dio/dio_factory.dart';

final injector = GetIt.instance;

Future<void> initializeDependencies() async {
  // Dio client
  injector.registerSingleton<Dio>(DioFactory(baseUrl).create());

  // Data - Remote
  injector.registerSingleton<PhotoService>(PhotoService(injector()));

  // Data - Local
  injector.registerLazySingleton<LocalDataSource>(() => LocalDataSourceImplementer());

  // Data - Repository
  injector.registerSingleton<PhotoRepository>(PhotoRepository(injector()));

  // Domain
  injector.registerSingleton<GetPhotosUseCase>(GetPhotosUseCase(injector(),injector()));
  // injector.registerSingleton<GetCharacterDetail>(GetCharacterDetail(injector(), injector()));

}

