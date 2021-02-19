import 'package:alpine_live/models/video_model.dart';

class Channel {

  final String id;
  final String title;
  final String profilePictureUrl;
  final String subscriberCount;
   String videoCount;
  final String uploadPlaylistId;

  List<Video> videos;

  Channel({this.id, this.title, this.profilePictureUrl, this.subscriberCount,
      this.videoCount, this.uploadPlaylistId, this.videos});

  factory Channel.fromMap(Map<String, dynamic> map) {
    return Channel(
      id: map['id'],
      title: map['snippet']['title'],
      profilePictureUrl: map['snippet']['thumbnails']['default']['url'],
      subscriberCount: map['statistics']['subscriberCount'],
      uploadPlaylistId: map['contentDetails']['relatedPlaylists']['uploads'],
    );
  }

}