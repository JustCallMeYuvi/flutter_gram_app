import 'package:flutter/material.dart';

import '../reel_item.dart';

class ReelsScreen extends StatelessWidget {
  const ReelsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> videos = [
      'assets/videos/cutiepathy.mp4',
      'assets/videos/thalapathy.mp4',
      'assets/videos/Tvk.mp4',
      'assets/videos/VijayOath.mp4',
      'assets/videos/MadhuraiVijaySelfieVideo.mp4',
    ];

    return Scaffold(
      backgroundColor: Colors.black,
      body: PageView.builder(
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          return ReelItem(
            videoPath: videos[index % videos.length],
            reelIndex: index,
          );
        },
      ),
    );
  }
}
