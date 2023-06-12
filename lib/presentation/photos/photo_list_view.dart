import 'package:cached_network_image/cached_network_image.dart';
import 'package:earnipay_task/app/widgets/app_bar.dart';
import 'package:earnipay_task/presentation/photos/photo_detail_view.dart';
import 'package:earnipay_task/presentation/photos/photos_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import '../../app/utils/assets_manager.dart';
import '../../app/widgets/empty_screen.dart';
import '../../app/widgets/error_screen.dart';
import '../../app/widgets/loading_screen.dart';
import '../../core/view_state.dart';


class PhotoListView extends StatelessWidget {
  const PhotoListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PhotoViewModel>.reactive(
        viewModelBuilder: () => PhotoViewModel(),
        onViewModelReady: (viewModel) {
          viewModel.loadPhotos();
        },
        builder: (context, viewModel, child) {
          return Scaffold(
            appBar: _buildAppBar(),
            body: _buildBody(context, viewModel),
          );
        });
  }

  Widget _buildBody(BuildContext context, PhotoViewModel viewModel) {
    switch (viewModel.viewState.state) {
      case ResponseState.LOADING:
        return const LoadingScreen();
      case ResponseState.COMPLETE:
        final items = viewModel.viewState.data ?? List.empty();
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
          child: GridView.builder(
            // if hasMore is true, add one more space for a loading indicator
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16
              ),
              itemCount: viewModel.hasMore ? items.length + 1 : items.length,
              itemBuilder: (context, index) {
                if (index >= items.length) {
                  // Don't fire another when one async is currently ongoing
                  if (!viewModel.busy(photosBusyKey)) {
                    viewModel.loadMorePhotos();
                  }
                  return Center(
                    child: Container(
                      padding: const EdgeInsets.only(top: 32, bottom: 32),
                      child: const SizedBox(
                        height: 24,
                        width: 24,
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  );
                }
                return InkWell(
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) {
                          return PhotoDetailView(photoDetails: items[index]);
                        }));
                  },
                  child: CachedNetworkImage(
                    imageUrl: items[index].urls?.smallS3 ?? "",
                    imageBuilder: (context, imageProvider) => Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.cover))),
                    placeholder: (context, url) => const SizedBox(
                        height: 25,
                        width: 25,
                        child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) => Image.asset(
                      ImageAssets.photoErrorImage,
                    ),
                  ),
                );
              }),
        );
      case ResponseState.ERROR:
        return ErrorScreen(errorMessage: viewModel.viewState.exception ?? "",
            onPressed: () {viewModel.loadPhotos();});
      case ResponseState.EMPTY:
        return const EmptyScreen();
    }
  }



  CustomAppBar _buildAppBar() {
    return const CustomAppBar(
      title: "Photos",
    );
  }
}
