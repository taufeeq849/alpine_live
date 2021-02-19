import 'package:alpine_live/app/locator.dart';
import 'package:alpine_live/models/video_model.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoViewModel extends BaseViewModel {
  YoutubePlayerController _youtubePlayerController;

  Video video;
  NavigationService _navigationService = locator<NavigationService>();

  YoutubePlayerController get youtubePlayerController =>
      _youtubePlayerController;

  init() {
    _youtubePlayerController = YoutubePlayerController(
        initialVideoId: video.id, flags: YoutubePlayerFlags(autoPlay: true));
  }

  popBack() => _navigationService.back();
}
