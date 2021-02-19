import 'package:alpine_live/constants/constants.dart';
import 'package:alpine_live/models/video_model.dart';
import 'package:alpine_live/ui/views/home/home_viewmodel.dart';
import 'package:alpine_live/widgets/video_card/video_card.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class HomeView extends StatelessWidget {
  HomeViewModel _homeViewModel = new HomeViewModel();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      onModelReady: (model) => model.fetchChannel(),
      viewModelBuilder: () => _homeViewModel,
      builder: (context, model, child) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.red,
            title: Text(
              'Youtube Video Player',
            ),
          ),
          body: model.channel != null
              ? model.channel.videos.length == 0
                  ? Center(
                      child: Text(
                        "No live streams available at the moment",
                        style: mainHeadingTextStyle,
                        textAlign: TextAlign.center,
                      ),
                    )
                  : NotificationListener<ScrollNotification>(
                      onNotification: (ScrollNotification scrollDetails) {
                        if (!model.isLoading &&
                            model.channel.videos.length !=
                                int.parse(model.channel.videoCount) &&
                            scrollDetails.metrics.pixels ==
                                scrollDetails.metrics.maxScrollExtent) {
                          model.loadMoreVideos();
                        }
                        return false;
                      },
                      child: ListView.builder(
                        itemCount: 1 + model.channel.videos.length,
                        itemBuilder: (BuildContext context, int index) {
                          if (index == 0) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 30),
                              child: Container(
                                child: Text(
                                  "Videos showing from: ${model.channel.title}",
                                  textAlign: TextAlign.center,
                                  style: mainHeadingTextStyle,
                                ),
                              ),
                            );
                          }
                          Video video = model.channel.videos[index - 1];
                          return GestureDetector(
                              onTap: () => model.navigateToVideoView(video),
                              child: VideoCard(video, index == 1 ? true: false));
                        },
                      ),
                    )
              : Center(
                  child: model.isError
                      ? Text("Error, try again later")
                      : CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Colors.red, // Red
                          ),
                        ),
                ),
        );
      },
    );
  }
}
