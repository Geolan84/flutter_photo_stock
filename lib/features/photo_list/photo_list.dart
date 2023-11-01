import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:photo_stock/domain/photo/photo.dart';
import 'package:photo_stock/features/photo_list/photo_list_widget_model.dart';

class PhotoListScreen extends ElementaryWidget<IPhotoListWidgetModel> {
  const PhotoListScreen({
    Key? key,
    WidgetModelFactory wmFactory = photoListScreenWMFactory,
  }) : super(wmFactory, key: key);

  @override
  Widget build(IPhotoListWidgetModel wm) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: EntityStateNotifierBuilder<Iterable<Photo>>(
        listenableEntityState: wm.photoListState,
        loadingBuilder: (_, __) => const _LoadingWidget(),
        errorBuilder: (_, __, ___) => const _ErrorWidget(),
        builder: (_, photos) => _PhotoList(
          photos: photos,
          alignTitleCenter: wm.alignTitleCenter,
          scrollController: wm.scrollController,
          isPageLoading: wm.isPageLoading,
        ),
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

class _PhotoList extends StatelessWidget {
  final Iterable<Photo>? photos;
  final ValueListenable<bool> alignTitleCenter;
  final ScrollController scrollController;
  final ValueListenable<bool> isPageLoading;

  const _PhotoList({
    required this.photos,
    required this.alignTitleCenter,
    required this.scrollController,
    required this.isPageLoading,
  });

  @override
  Widget build(BuildContext context) {
    final photos = this.photos;

    if (photos == null || photos.isEmpty) {
      return const _EmptyList();
    }

    return CustomScrollView(
      controller: scrollController,
      slivers: [
        SliverAppBar(
          backgroundColor: Colors.white.withAlpha(250),
          expandedHeight: 80,
          pinned: true,
          flexibleSpace: FlexibleSpaceBar(
            centerTitle: true,
            titlePadding:
                const EdgeInsets.only(left: 20, right: 20, bottom: 10),
            title: ValueListenableBuilder<bool>(
              valueListenable: alignTitleCenter,
              builder: (_, align, __) {
                return AnimatedAlign(
                  alignment:
                      align ? Alignment.bottomLeft : Alignment.bottomCenter,
                  duration: const Duration(milliseconds: 150),
                  child: const Text(
                    'Photos',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black),
                  ),
                );
              },
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.all(20),
          sliver: SliverGrid(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 15,
              crossAxisSpacing: 15,
            ),
            delegate: SliverChildBuilderDelegate(
              (_, index) {
                if (index < photos.length) {
                  return _PhotoCard(photo: photos.elementAt(index));
                } else {
                  return const CircularProgressIndicator();
                }
              },
              childCount: photos.length,
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: ValueListenableBuilder<bool>(
              valueListenable: isPageLoading,
              builder: (_, loading, __) {
                return loading
                    ? const _LoadingWidget()
                    : const SizedBox.shrink();
              }),
        ),
      ],
    );
  }
}

class _PhotoCard extends StatelessWidget {
  final Photo photo;
  const _PhotoCard({required this.photo});

  @override
  Widget build(BuildContext context) {
    final photo_image = Image.network(
      photo.imageLink,
      loadingBuilder: (_, child, loadingProgress) {
        if (loadingProgress == null) {
          return child;
        }
        return BlurHash(hash: photo.blurHash);
      },
      frameBuilder: (_, child, __, ___) {
        return child;
      },
      fit: BoxFit.fill,
    );
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            spreadRadius: 1,
            color: Color(int.parse(photo.color.substring(1, 7), radix: 16) +
                    0xFF000000)
                .withOpacity(0.8),
            blurRadius: 4,
          )
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Stack(
          alignment: Alignment.center,
          fit: StackFit.expand,
          children: [
            photo_image,
            Positioned(
              bottom: 10,
              left: 10,
              right: 10,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    photo.username,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    softWrap: false,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      shadows: [
                        Shadow(
                          offset: Offset(1, 1),
                          blurRadius: 4,
                        )
                      ],
                    ),
                  ),
                  Text(
                    '${photo.likes} likes',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      shadows: [
                        Shadow(
                          offset: Offset(1, 1),
                          blurRadius: 4,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _EmptyList extends StatelessWidget {
  const _EmptyList();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Список пуст'),
    );
  }
}
