import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:photo_stock/domain/photo/photo.dart';
import 'package:photo_stock/features/photo_list/photo_list_widget_model.dart';
import 'package:photo_stock/util/app_dictionary.dart';

/// Class for screen with list of photos.
class PhotoListScreen extends ElementaryWidget<IPhotoListWidgetModel> {
  /// @nodoc
  const PhotoListScreen({
    Key? key,
    WidgetModelFactory wmFactory = photoListScreenWMFactory,
  }) : super(wmFactory, key: key);

  @override
  Widget build(IPhotoListWidgetModel wm) {
    return Scaffold(
      backgroundColor: wm.theme.colorScheme.primary,
      body: EntityStateNotifierBuilder<Iterable<Photo>>(
        listenableEntityState: wm.photoListState,
        loadingBuilder: (_, __) => const _LoadingWidget(),
        errorBuilder: (_, __, ___) => const _ErrorWidget(),
        builder: (_, photos) => _PhotoList(
            photos: photos,
            alignTitleCenter: wm.alignTitleCenter,
            scrollController: wm.scrollController,
            isPageLoading: wm.isPageLoading,
            wm: wm),
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
      child: Text(AppDictionary.mainScreenError),
    );
  }
}

class _PhotoList extends StatelessWidget {
  final Iterable<Photo>? photos;
  final ValueListenable<bool> alignTitleCenter;
  final ScrollController scrollController;
  final ValueListenable<bool> isPageLoading;
  final IPhotoListWidgetModel wm;

  const _PhotoList(
      {required this.photos,
      required this.alignTitleCenter,
      required this.scrollController,
      required this.isPageLoading,
      required this.wm});

  @override
  Widget build(BuildContext context) {
    final photos = this.photos;
    final photoListAppBar = SliverAppBar(
      backgroundColor: Theme.of(context).colorScheme.primary.withAlpha(250),
      surfaceTintColor: Theme.of(context).colorScheme.primary.withAlpha(250),
      expandedHeight: 80,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        titlePadding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
        title: ValueListenableBuilder<bool>(
          valueListenable: alignTitleCenter,
          builder: (_, align, __) {
            return AnimatedAlign(
              alignment: align ? Alignment.bottomLeft : Alignment.bottomCenter,
              duration: const Duration(milliseconds: 150),
              child: Text(
                AppDictionary.photoListAppBarTitle,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.displayMedium,
              ),
            );
          },
        ),
      ),
    );

    return CustomScrollView(
      controller: scrollController,
      slivers: (photos == null || photos.isEmpty)
          ? [
              photoListAppBar,
              const SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.only(top: 50),
                  child: _EmptyList(),
                ),
              ),
            ]
          : [
              photoListAppBar,
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
                        return _PhotoCard(
                          photo: photos.elementAt(index),
                          wm: wm,
                        );
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
  final IPhotoListWidgetModel wm;

  const _PhotoCard({required this.photo, required this.wm});

  @override
  Widget build(BuildContext context) {
    final photoImage = Image.network(
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
    return InkWell(
      onTap: () {
        wm.moveToPhotoDetail(photo, photoImage);
      },
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              spreadRadius: 1,
              color: Color(photo.color).withOpacity(0.8),
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
              photoImage,
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
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Text('${photo.likes} ${AppDictionary.likesTitle}',
                        style: Theme.of(context).textTheme.titleSmall),
                  ],
                ),
              ),
            ],
          ),
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
      child: Text(AppDictionary.photoEmptyList),
    );
  }
}
