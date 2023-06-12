import 'package:dio/dio.dart';
import 'package:earnipay_task/app/di/injector.dart';
import 'package:earnipay_task/data/model/remote/PhotoApiResponse.dart';
import 'package:earnipay_task/data/remote/service/photo/photo_service.dart';
import 'package:earnipay_task/data/repository/photo_repository.dart';
import 'package:earnipay_task/presentation/photos/photos_view_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:retrofit/dio.dart';


class MockPhotoService extends Mock implements PhotoService{}

void main(){
  initializeDependencies();
  late PhotoRepository photoRepository;
  MockPhotoService mockPhotoService = MockPhotoService();
  late PhotoViewModel photoViewModel;
  setUp((){
    photoRepository = PhotoRepository(mockPhotoService);
    photoViewModel = PhotoViewModel();
  });

  group("getPhotos", () {
    List<PhotoApiResponse> photosFromService = [
      PhotoApiResponse(id: "1"),
      PhotoApiResponse(id: "2"),
      PhotoApiResponse(id:"3"),
    ];

    void arrangePhotosServiceReturns3Photos(){
      when(() => mockPhotoService.getPhotos(1)).
      thenAnswer((_) async =>
          HttpResponse(photosFromService, Response(requestOptions: RequestOptions(path: ''))));
    }

    test("get photos using the photos service successfully", () async{
      arrangePhotosServiceReturns3Photos();
      photoRepository.getPhotos(1);
      verify(()=> mockPhotoService.getPhotos(1)).called(1);
    });

    test("verify the repo handles error gracefully when page is less than 1", () async{
      expect(() => photoRepository.getPhotos(-1), throwsException);
    });
  });
}