import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:photo_stock/domain/photo/photo.dart';
import 'package:photo_stock/features/photo_detail/photo_detail_widget_model.dart';

class PhotoDetailScreen extends ElementaryWidget<IPhotoDetailWidgetModel> {
  final Image photoImage;
  final Photo photo;
  const PhotoDetailScreen({
    required this.photo,
    required this.photoImage,
    Key? key,
    WidgetModelFactory wmFactory = photoDetailWMFactory,
  }) : super(wmFactory, key: key);

  @override
  Widget build(IPhotoDetailWidgetModel wm) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: EntityStateNotifierBuilder<Photo>(
        listenableEntityState: wm.photoDetailState,
        loadingBuilder: (_, __) => const _LoadingWidget(),
        errorBuilder: (_, __, ___) => const _ErrorWidget(),
        builder: (_, __) => _Photo(
          photo: photo,
          photoImage: photoImage,
        ),
      ),
    );
  }
}

class _Photo extends StatelessWidget {
  final Photo? photo;
  final Image photoImage;

  const _Photo({
    required this.photo,
    required this.photoImage,
  });

  @override
  Widget build(BuildContext context) {
    final photo = this.photo;

    if (photo == null) {
      return const _EmptyPhoto();
    }
    return SingleChildScrollView(
      child: Column(
        children: [
          Stack(
            children: [
              ClipRRect(
                child: photoImage,
                borderRadius:
                    const BorderRadius.vertical(bottom: Radius.circular(24)),
              ),
              Positioned(
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Row(
                    children: [
                      Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                        size: 15,
                      ),
                      Text(
                        'Back',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
                top: 40,
                left: 20,
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        photo.username,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        softWrap: false,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 32),
                      ),
                      Text(
                        '${photo.likes} likes',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _LoadingWidget extends StatelessWidget {
  const _LoadingWidget();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        child: CircularProgressIndicator(),
        padding: EdgeInsets.only(bottom: 30, top: 20),
      ),
    );
  }
}

class _ErrorWidget extends StatelessWidget {
  const _ErrorWidget();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Error'),
    );
  }
}

class _EmptyPhoto extends StatelessWidget {
  const _EmptyPhoto();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Такого фото не существует.'),
    );
  }
}
