import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:video_player/video_player.dart';

class NewsVideoView extends StatefulWidget {
  ///
  ///
  const NewsVideoView({
    Key? key,
    required this.video,
    required this.width,
    required this.height,
  }) : super(key: key);

  final String video;
  final int width;
  final int height;

  @override
  NewsVideoViewState createState() => NewsVideoViewState();
}

class NewsVideoViewState extends State<NewsVideoView> {
  ///
  ///
  late VideoPlayerController _playerController;
  late ChewieController _chewieController;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFF6F6F6),
      margin: EdgeInsets.only(top: 16.w),
      child: AspectRatio(
        aspectRatio: widget.width / widget.height,
        child: Chewie(
          controller: _chewieController,
        ),
      ),
    );
  }

  Future<void> _initialize() async {
    _playerController =
        VideoPlayerController.networkUrl(Uri.parse(widget.video));
    _chewieController = ChewieController(
      videoPlayerController: _playerController,
      autoPlay: false,
      looping: false,
      showOptions: false,
      allowFullScreen: false,
      autoInitialize: true,
      aspectRatio: widget.width / widget.height,
    );
  }

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  @override
  void dispose() {
    super.dispose();
    _playerController.dispose();
    _chewieController.dispose();
  }
}
