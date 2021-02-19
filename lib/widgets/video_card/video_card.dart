import 'package:alpine_live/models/video_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class VideoCard extends StatelessWidget {
  Video video;
  bool isFirst;

  VideoCard(this.video, this.isFirst);

  Widget _buildisLiveIndicator() {
    return Container(

      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            offset: Offset(0, 1),
            blurRadius: 6.0,
          ),
        ],
      ),
      child: Text(
        "LIVE",
        style: new TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
            fontSize: 12),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
      padding: EdgeInsets.all(10.0),
      height: 140.0,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            offset: Offset(0, 1),
            blurRadius: 10.0,
          ),
        ],
      ),
      child: Row(
        children: <Widget>[
          Image.network(video.thumbnailUrl, width: 150.0, loadingBuilder:
              (BuildContext context, Widget child,
                  ImageChunkEvent loadingProgress) {
            if (loadingProgress == null) {
              return child;
            } else {
              return Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.black,
                ),
              );
            }
          }),
          SizedBox(width: 10.0),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  video.title,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18.0,
                  ),
                ),
                isFirst ? _buildisLiveIndicator() : Container()
              ],
            ),
          ),
        ],
      ),
    );
  }
}
