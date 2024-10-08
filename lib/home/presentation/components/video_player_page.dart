import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerPage extends StatefulWidget {
  final String videoUrl;
  final bool autoPlay;


  const VideoPlayerPage({required this.videoUrl,this.autoPlay=false});

  @override
  _VideoPlayerPageState createState() => _VideoPlayerPageState();
}

class _VideoPlayerPageState extends State<VideoPlayerPage> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.videoUrl)
      ..initialize().then((_) {
        setState(() {
          if (widget.autoPlay) {
            _controller.play();
          }
        });
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return
      _controller.value.isInitialized
          ? AspectRatio(
        aspectRatio: _controller.value.aspectRatio,
        child: Stack(children:[
          VideoPlayer(_controller),
          Positioned(
            bottom: 26,
            left: 9,
            right: 9,
            child: IconButton(onPressed: (){
              setState(() {
                _controller.value.isPlaying
                    ? _controller.pause()
                    : _controller.play();
                _controller.setLooping(true);
              });
            }, icon: Icon(
              _controller.value.isPlaying ? Icons.pause: Icons.play_arrow,
            ),color:Colors.blue),
          )
        ]),
      )
          : Padding(
            padding: const EdgeInsets.symmetric(horizontal:150,vertical: 150),
            child: SizedBox(
              width: 6,
                height: 6,
                child: CircularProgressIndicator()),
          );
  }
}
