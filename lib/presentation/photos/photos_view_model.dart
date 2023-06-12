import 'dart:developer';

import 'package:earnipay_task/data/model/remote/PhotoApiResponse.dart';
import 'package:earnipay_task/domain/photo/get_photos_usecase.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:stacked/stacked.dart';

import '../../app/di/injector.dart';
import '../../core/view_state.dart';
import '../../data/remote/dio/data_state.dart';

const photosBusyKey = 'photos';

class PhotoViewModel extends BaseViewModel {
  final GetPhotosUseCase _getPhotosUseCase = injector<GetPhotosUseCase>();

  ViewState<List<PhotoApiResponse>> viewState = ViewState(state: ResponseState.EMPTY);

  final List<PhotoApiResponse> photoList = [];
  int page = 1;
  static const int _pageSize = 10;
  bool hasMore = true;
  ScrollController? controller;

  void _setViewState(ViewState<List<PhotoApiResponse>> viewState) {
    this.viewState = viewState;
    setBusyForObject(photosBusyKey, false);
  }

  void loadPhotos() async {
    await loadMorePhotos();
  }

  Future<void> loadMorePhotos() async {
    if (page == 1) _setViewState(ViewState.loading());

    final apiResult = await _getPhotosUseCase.execute(params: GetPhotoParams(page: page));

    if (apiResult is DataSuccess) {
      final list = apiResult.data ?? List.empty();
      if (list.isEmpty) {
        hasMore = false;
        setBusyForObject(photosBusyKey, false);
      } else {
        photoList.addAll(list);
        log("${photoList.length}");
        page++;
        _setViewState(ViewState.complete(photoList));
      }
    }
    if (apiResult is DataFailed) {
      if (kDebugMode) {
        print(apiResult.error);
      }
      _setViewState(ViewState.error(apiResult.error.toString()));
    }
  }
}