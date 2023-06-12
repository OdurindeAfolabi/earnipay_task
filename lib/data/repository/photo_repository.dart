import 'package:earnipay_task/data/model/remote/PhotoApiResponse.dart';
import 'package:earnipay_task/data/remote/service/photo/photo_service.dart';
import 'package:retrofit/retrofit.dart';

class PhotoRepository {
  final PhotoService _photoService;

  PhotoRepository(this._photoService);

  Future<HttpResponse<List<PhotoApiResponse>>> getPhotos(
    int page,
  ) {
    if(page < 1){
      throw Exception("invalid page");
    }
    else{
      return _photoService.getPhotos(page);
    }
  }
}
