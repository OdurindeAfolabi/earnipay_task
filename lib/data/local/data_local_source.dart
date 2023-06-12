
// ignore_for_file: constant_identifier_names
import 'package:earnipay_task/data/model/remote/PhotoApiResponse.dart';

const CACHE_PHOTOS_KEY = "CACHE_PHOTOS_KEY";
const CACHE_PHOTOS_INTERVAL = 120 * 1000; // 1 MINUTE IN MILLIS

abstract class LocalDataSource {
  Future<List<PhotoApiResponse>> getCachedPhotos();
  Future<void> savePhotosToCache(List<PhotoApiResponse> photoApiResponse);

  void clearCache();

  void removeFromCache(String key);

}

class LocalDataSourceImplementer implements LocalDataSource {
  // run time cache
  Map<String, CachedItem> cacheMap = {};

  @override
  Future<List<PhotoApiResponse>> getCachedPhotos() async {
    CachedItem? cachedItem = cacheMap[CACHE_PHOTOS_KEY];

    if (cachedItem != null && cachedItem.isValid(CACHE_PHOTOS_INTERVAL)) {
      return cachedItem.data;
      // return the response from cache
    } else {
      // return error that cache is not valid
      throw "Error fetching from cache";
    }
  }

  @override
  Future<void> savePhotosToCache(List<PhotoApiResponse> photoApiResponse) async {
    cacheMap[CACHE_PHOTOS_KEY] = CachedItem(photoApiResponse);
  }

  @override
  void clearCache() {
    cacheMap.clear();
  }

  @override
  void removeFromCache(String key) {
    cacheMap.remove(key);
  }
}

class CachedItem {
  dynamic data;

  int cacheTime = DateTime.now().millisecondsSinceEpoch;

  CachedItem(this.data);
}

extension CachedItemExtension on CachedItem {
  bool isValid(int expirationTime) {
    // expirationTime is 60 secs
    int currentTimeInMillis =
        DateTime.now().millisecondsSinceEpoch; // time now is 1:00:00 pm

    bool isCacheValid = currentTimeInMillis - expirationTime <
        cacheTime; // cache time was in 12:59:30
    // false if current time > 1:00:30
    // true if current time <1:00:30
    return isCacheValid;
  }
}

