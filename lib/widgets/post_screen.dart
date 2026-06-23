import 'package:flutter/material.dart';

class PostScreen extends StatelessWidget {
    final String username;
  final String profileImage;
  final String postImage;
  const PostScreen({super.key, required this.username, required this.profileImage, required this.postImage});

  @override
  Widget build(BuildContext context) {
    // return Container(
    return Material(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           ListTile(
            dense: true,
            title:  Text(
              // 'just_call_me_yuvi_',
              username,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
            subtitle: const Text(
              'Chennai',
              style:
                  TextStyle(fontWeight: FontWeight.normal, color: Colors.black),
            ),
            leading:  CircleAvatar(
              radius: 20,
              // backgroundImage: NetworkImage(
              //   'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRufgpbhv968acPDGlPv-9g9a73QL5UPBj3JA&s',
              // ),
              backgroundImage: AssetImage(profileImage),
            ),
            trailing: const Icon(Icons.more_vert),
          ),
          Image.asset(
            // 'images/reels.jpeg',
              postImage,
            width: double.infinity,
            height: 320,
            fit: BoxFit.cover,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.favorite_outline_outlined),
                iconSize: 30,
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.chat_bubble_outline),
                iconSize: 30,
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.send_outlined),
                iconSize: 30,
              ),
              const Spacer(),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.bookmark),
                iconSize: 30,
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '193,046 likes',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  'JustCallMeYuvi',
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  '5 Minutes age',
                  style: TextStyle(),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
