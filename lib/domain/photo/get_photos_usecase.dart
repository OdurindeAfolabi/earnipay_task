import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:earnipay_task/data/model/remote/PhotoApiResponse.dart';
import 'package:earnipay_task/data/repository/photo_repository.dart';
import 'package:flutter/foundation.dart';
import '../../core/use_case.dart';
import '../../data/local/data_local_source.dart';
import '../../data/remote/dio/data_state.dart';
import '../../data/remote/dio/dio_exception.dart';

class GetPhotosUseCase implements UseCase<DataState<List<PhotoApiResponse>>, GetPhotoParams> {
  final PhotoRepository _photoRepository;
  final LocalDataSource _localDataSource;

  GetPhotosUseCase(this._photoRepository, this._localDataSource);

  @override
  Future<DataState<List<PhotoApiResponse>>> execute(
      {required GetPhotoParams params}) async {
    try {
      // get from cache
      if(params.page < 5) {
        final response = await _localDataSource.getCachedPhotos();
        return DataSuccess(response);
      }
      else{
        throw Exception("cache error");
      }
    } catch (cacheError) {
      log("fetching from api");
      // we have cache error so we should call API
      try {
        final httpResponse = await _photoRepository.getPhotos(
          params.page,
        );
        if (httpResponse.response.statusCode == HttpStatus.ok) {
          _localDataSource.savePhotosToCache(httpResponse.data);
          return DataSuccess(httpResponse.data);
        }
        return DataFailed(httpResponse.response.statusMessage);
      } on DioError catch (e) {
        final errorMessage = DioException.fromDioError(e).toString();
        if (kDebugMode) {
          print(errorMessage);
        }
        return DataFailed(errorMessage);
      } catch (e) {
        if (kDebugMode) {
          print(e);
        }
        return DataFailed(e.toString());
      }
    }
  }
}

class GetPhotoParams {
  final int page;

  GetPhotoParams({required this.page});
}
