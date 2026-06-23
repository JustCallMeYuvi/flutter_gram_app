import 'package:flutter/material.dart';
import 'package:flutter_gram_app/services/storage_service.dart';

import 'package:share_plus/share_plus.dart';
import 'package:video_player/video_player.dart';

class ReelItem extends StatefulWidget {
  final String videoPath;
  final int reelIndex;

  const ReelItem({
    super.key,
    required this.videoPath,
    required this.reelIndex,
  });

  @override
  State<ReelItem> createState() => _ReelItemState();
}

class _ReelItemState extends State<ReelItem> {
  late VideoPlayerController controller;

  bool isLiked = false;
  int likes = 0;
  List<String> comments = [];

  bool showHeart = false;
  final StorageService storageService = StorageService();

  @override
  void initState() {
    super.initState();

    isLiked = storageService.getLikeStatus(widget.reelIndex);

    likes = storageService.getLikesCount(widget.reelIndex);

    comments = storageService.getComments(widget.reelIndex);

    controller = VideoPlayerController.asset(widget.videoPath)
      ..initialize().then((_) {
        setState(() {});
        controller.play();
        controller.setLooping(true);
      });
  }

  @override
  // Dispose video controller
  void dispose() {
    controller.dispose();
    super.dispose();
  }

// Show comments bottom sheet
  void addComment() {
    TextEditingController commentController = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: SizedBox(
                height: 500,
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    Container(
                      width: 50,
                      height: 5,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    const SizedBox(height: 15),
                    const Text(
                      "Comments",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Divider(),
                    Expanded(
                      child: comments.isEmpty
                          ? const Center(
                              child: Text(
                                "No comments yet",
                              ),
                            )
                          : ListView.builder(
                              itemCount: comments.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  leading: const CircleAvatar(
                                    child: Icon(Icons.person),
                                  ),
                                  title: Text(
                                    comments[index],
                                  ),
                                );
                              },
                            ),
                    ),
                    const Divider(height: 1),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 8,
                      ),
                      child: Row(
                        children: [
                          const CircleAvatar(
                            child: Icon(Icons.person),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: TextField(
                              controller: commentController,
                              decoration: const InputDecoration(
                                hintText: "Add a comment...",
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              if (commentController.text.trim().isNotEmpty) {
                                setState(() {
                                  comments.add(
                                    commentController.text.trim(),
                                  );
                                });

                                // reelsBox.put(
                                //   'comments_${widget.reelIndex}',
                                //   comments,
                                // );
                                storageService.saveComments(
                                  widget.reelIndex,
                                  comments,
                                );

                                setModalState(() {});
                                commentController.clear();
                              }
                            },
                            child: const Text(
                              "Post",
                              style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

// Like / Unlike reel method
  void toggleLike() {
    setState(() {
      if (isLiked) {
        isLiked = false;
        if (likes > 0) likes--;
      } else {
        isLiked = true;
        likes++;
      }
    });

// Save likes count
    storageService.saveLikesCount(
      widget.reelIndex,
      likes,
    );

    storageService.saveLikeStatus(
      widget.reelIndex,
      isLiked,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (!controller.value.isInitialized) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return Stack(
      fit: StackFit.expand,
      children: [
        GestureDetector(
          onDoubleTap: () {
            if (!isLiked) {
              toggleLike();
            }
            setState(() {
              showHeart = true;
            });
            Future.delayed(const Duration(milliseconds: 700), () {
              if (mounted) {
                setState(() {
                  showHeart = false;
                });
              }
            });
          },
          child: FittedBox(
            fit: BoxFit.cover,
            child: SizedBox(
              width: controller.value.size.width,
              height: controller.value.size.height,
              child: VideoPlayer(controller),
            ),
          ),
        ),
        if (showHeart)
          const Center(
            child: Icon(
              Icons.favorite,
              color: Colors.white,
              size: 120,
            ),
          ),
        const Positioned(
          left: 15,
          bottom: 30,
          right: 80,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 18,
                    backgroundImage: AssetImage(
                      'images/profile.jpg',
                    ),
                  ),
                  SizedBox(width: 10),
                  Text(
                    'just_call_me_yuvi_',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Text(
                'Thalapathy Reels Demo 🔥',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
              SizedBox(height: 5),
              Text(
                '🎵 Original Audio',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
        Positioned(
          right: 15,
          bottom: 120,
          child: Column(
            children: [
              IconButton(
                onPressed: toggleLike,
                icon: Icon(
                  isLiked ? Icons.favorite : Icons.favorite_border,
                  color: Colors.red,
                  size: 35,
                ),
              ),
              Text(
                likes.toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 15),
              IconButton(
                onPressed: addComment,
                icon: const Icon(
                  Icons.comment,
                  color: Colors.white,
                  size: 35,
                ),
              ),
              Text(
                comments.length.toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 15),
              IconButton(
                onPressed: () async {
                  // Share reel
                  await Share.share(
                    'Watch Reel ${widget.reelIndex + 1} from FlutterGram App',
                    subject: 'FlutterGram Reel',
                  );
                },
                icon: const Icon(
                  Icons.share,
                  color: Colors.white,
                  size: 35,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
