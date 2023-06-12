import 'package:earnipay_task/app/di/injector.dart';
import 'package:earnipay_task/presentation/photos/photos_view_model.dart';
import 'package:flutter_test/flutter_test.dart';


void main() {
  initializeDependencies();
  group('photoViewModel', () {
    late PhotoViewModel sut;

    setUp(() {
      // Create a mock instance of the PhotoService
      sut = PhotoViewModel();
    });

    test('Test case 1: initial values are correct', (){
      expect(sut.hasMore,true);
      expect(sut.page,1);
      expect(sut.photoList,[]);
    });

    test('Test case 2: To test the hasMore variable successfully changes to true to indicate there are more pictures to be loaded', () async {
      sut.loadPhotos();
      expect(sut.hasMore,true);
    });
  });
}
