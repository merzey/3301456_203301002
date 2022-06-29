import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';


class VideoSayfasi extends StatefulWidget {

  final String id;

  const VideoSayfasi({required this.id});


  @override
  State<VideoSayfasi> createState() => _VideoSayfasiState();
}

class _VideoSayfasiState extends State<VideoSayfasi> {

   late YoutubePlayerController  _controller;

  @override

  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: widget.id,
      flags: YoutubePlayerFlags(
        mute: false,
        autoPlay: true,
      ),
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: YoutubePlayer(
        controller: _controller,
        showVideoProgressIndicator: true,
        onReady: () {
          print('Player is ready.');
        },),
    );
  }
}
