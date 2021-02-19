import 'dart:io';

import 'package:alpine_live/models/video_model.dart';
import 'package:http/http.dart' as http;
import 'package:alpine_live/models/channel_model.dart';
import 'package:alpine_live/utilities/keys.dart';
import 'dart:convert';

class YoutubeAPIService {
  final String _baseUrl = 'www.googleapis.com';
  String _nextPageToken = '';

  Future fetchChannel({String channelId}) async {
    Map<String, String> parameters = {
      'part': 'snippet, contentDetails, statistics',
      'id': channelId,
      'key': YOUTUBE_KEY,
    };
    Uri uri = Uri.https(
      _baseUrl,
      '/youtube/v3/channels',
      parameters,
    );
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };

    // Get Channel
    var response = await http.get(uri, headers: headers);
    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body)['items'][0];
      print(data['statistics']);
      Channel channel = Channel.fromMap(data);

      // Fetch first batch of videos from uploads playlist

      var initialVideos = await fetchVideosFromPlaylist(
        channel: channel,
      );
      if (initialVideos is String) {
        return initialVideos;
      }
      channel.videos = initialVideos;
      return channel;
    } else {
      return json.decode(response.body)['error']['message'];
    }
  }

  Future fetchVideosFromPlaylist({Channel channel}) async {
    /* Map<String, String> parameters = {
      'part': 'snippet',
      'channelId': channelId,
      'maxResults': '8',
      'pageToken': _nextPageToken,
      'eventType': 'live',
      'type': 'video',
      'key': YOUTUBE_KEY,
    };*/
    /*  Uri uri = Uri.https(
      _baseUrl,
      '/youtube/v3/search',
      parameters,
    );*/

    String url =
        "https://www.googleapis.com/youtube/v3/search?part=snippet&channelId=${channel.id}&eventType=live&maxResults=8&pageToken=${_nextPageToken}&type=video&key=${YOUTUBE_KEY}";

    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };

    // Get Playlist Videos
    var response = await http.get(url, headers: headers);
    if (response.statusCode == 200) {
      var data = json.decode(response.body);

      _nextPageToken = data['nextPageToken'] ?? '';
      List<dynamic> videosJson = data['items'];

      // Fetch first eight videos from uploads playlist
      List<Video> videos = [];
      int videoCount = 0;
      videosJson.forEach(
        (json) {
          videoCount++;
          print(json);
          videos.add(
            Video.fromMap(json),
          );
        },
      );
      channel.videoCount = videoCount.toString();
      return videos;
    } else {
      print(json.decode(response.body)['error']['message']);
      return json.decode(response.body)['error']['message'];
    }
  }
}
