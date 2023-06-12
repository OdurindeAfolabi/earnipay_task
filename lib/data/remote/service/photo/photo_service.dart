import 'package:dio/dio.dart';
import 'package:earnipay_task/data/model/remote/PhotoApiResponse.dart';
import 'package:retrofit/retrofit.dart';

part 'photo_service.g.dart';

@RestApi()
abstract class PhotoService {
  factory PhotoService(Dio dio) = _PhotoService;

  @GET("photos")
  Future<HttpResponse<List<PhotoApiResponse>>> getPhotos(
    @Query("page") int page,
  );
}
