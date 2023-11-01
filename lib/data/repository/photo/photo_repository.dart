import 'package:photo_stock/domain/photo/photo.dart';

class PhotoRepository {
  Future<Iterable<Photo>> getAllPhotos() async {
    //Imitation of work.
    await Future.delayed(const Duration(seconds: 1));
    return Future(
      () => List<Photo>.generate(
        10,
        (index) => Photo(
          imageLink:
              'https://wallpapers.com/images/hd/funny-shrek-h7n6n0iogb00kcan.jpg',
          username: 'Shrek${index + 1}',
          likes: 28,
          color: '#260c0c',
          blurHash: 'L78zPlIW0zEgoyIpsps.0gIp^%-T',
        ),
      ),
    );
  }
}
