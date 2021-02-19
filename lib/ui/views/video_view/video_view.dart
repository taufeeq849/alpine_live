import 'package:alpine_live/app/locator.dart';
import 'package:alpine_live/constants/constants.dart';
import 'package:alpine_live/models/channel_model.dart';
import 'package:alpine_live/models/video_model.dart';
import 'package:alpine_live/widgets/channel_info/channel_info.dart';
import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:timer_builder/timer_builder.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoView extends StatefulWidget {
  Video video;
  Channel channel;

  VideoView(this.video, this.channel);

  @override
  _VideoViewState createState() => _VideoViewState();
}

class _VideoViewState extends State<VideoView> {
  YoutubePlayerController _controller;


  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: widget.video.id,
      flags: YoutubePlayerFlags(
        mute: false,
        autoPlay: true,


      ),
    );
  }

  Widget _buildTopRow() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 50, 0, 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () => locator<NavigationService>().back()),
          Flexible(
              child: Text(widget.video.title, style: mainHeadingTextStyle)),
          Container()
        ],
      ),
    );
  }

  Widget _buildYoutubePlayer() {
    return YoutubePlayer(
      controller: _controller,
      progressIndicatorColor: Colors.red,
      bottomActions: [
        CurrentPosition(),
        ProgressBar(isExpanded: true),
        RemainingDuration(),
        FullScreenButton(),
      ],
      topActions: [PlaybackSpeedButton()],
      onReady: () {
      },
    );
  }

  Widget _buildDescriptionBox() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      child: Container(
        padding: EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              offset: Offset(0, 1),
              blurRadius: 6.0,
            ),
          ],
        ),
        child: Column(
          children: [
            Text(
              "Description",
              style: subHeadingTextStyle,
              textAlign: TextAlign.left,
            ),
            SizedBox(height: 10),
            Text(
              widget.video.description.length == 0
                  ? "Nothing here."
                  : widget.video.description,
              style: infoTextStyle,
              textAlign: TextAlign.left,
            )
          ],
        ),
      ),
    );
  }

  Widget _buildTimeofDay() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      child: Container(
        padding: EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              offset: Offset(0, 1),
              blurRadius: 6.0,
            ),
          ],
        ),
        child: Column(
          children: [
            Text(
              "Your current time: ",
              style: subHeadingTextStyle,
              textAlign: TextAlign.left,
            ), SizedBox(height: 10),
            TimerBuilder.periodic(
              Duration(seconds: 1),
              builder: (context) {
                print(_controller.value.position);
                return Text(
                    DateTime.now()
                        .toString()
                        .substring(0, DateTime.now().toString().indexOf(".")),
                    style: infoTextStyle);
              },
            ),

          ],
        ),
      ),
    );
  }

  Widget _buildChannelInfo() {
    return Column(
      children: [ChannelInfo(widget.channel)],
    );
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(

        player: _buildYoutubePlayer(),
        builder: (context, player) {
          return Scaffold(
            body: SingleChildScrollView(
              child:
              Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                _buildTopRow(),
                player,
                _buildDescriptionBox(),
                _buildTimeofDay(),
                _buildChannelInfo()
              ]),
            ),
          );
        });
  }
}
