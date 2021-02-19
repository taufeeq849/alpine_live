import 'package:alpine_live/app/locator.dart';
import 'package:alpine_live/app/router.gr.dart';
import 'package:alpine_live/models/channel_model.dart';
import 'package:alpine_live/models/video_model.dart';
import 'package:alpine_live/models/video_view_argumentmodel.dart';
import 'package:alpine_live/services/youtubeapi_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class HomeViewModel extends BaseViewModel {
  Channel _channel;
  bool _isLoading = false;
  DialogService _dialogService = locator<DialogService>();
  NavigationService _navigationService = locator<NavigationService>();
  YoutubeAPIService _youtubeAPIService = locator<YoutubeAPIService>();
  bool isError = false;

  //production channel
  String _channelID = "UCX6QXfc1dVNuadoICvULqHg";

  //temp
 // String _channelID = "UCoMdktPbSTixAyNGwb-UYkQ";

  fetchChannel() async {
    setisLoading(true);
    try {
      var temp = await _youtubeAPIService.fetchChannel(channelId: _channelID);
      if (temp is String) {
        _dialogService.showDialog(title: 'Error', description: temp);
        return;
      }
      _channel = temp;
      notifyListeners();
    } catch (e) {
      setisError(true);
      _dialogService.showDialog(title: 'Error', description: e.toString());
    }
    setisLoading(false);
  }

  Channel get channel => _channel;

  navigateToVideoView(Video video) {
    VideoViewArgumentModel videoViewArgumentModel =
        VideoViewArgumentModel(_channel, video);
    _navigationService.navigateTo(
      Routes.videoView,
      arguments: videoViewArgumentModel,
    );
  }

  loadMoreVideos() async {
    setisLoading(true);
    try {
      var moreVideos =
          await _youtubeAPIService.fetchVideosFromPlaylist(channel: _channel);
      if (moreVideos is String) {
        _dialogService.showDialog(
            title: 'Error', description: moreVideos.toString());
        return;
      }
      List<Video> allVideos = _channel.videos..addAll(moreVideos);
      if (allVideos is String) {}
      _channel.videos = allVideos;
    } catch (e) {
      setisError(true);
      _dialogService.showDialog(title: 'Error', description: e.toString());
    }

    setisLoading(false);
  }

  setisLoading(bool x) {
    _isLoading = x;
    notifyListeners();
  }

  setisError(bool x) {
    isError = x;
    notifyListeners();
  }

  bool get isLoading => _isLoading;
}
