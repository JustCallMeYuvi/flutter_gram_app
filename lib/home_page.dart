import 'package:flutter/material.dart';
import 'package:flutter_gram_app/widgets/add_story_screen.dart';
import 'package:flutter_gram_app/widgets/custom_app_bar.dart';
import 'package:flutter_gram_app/widgets/post_screen.dart';
import 'package:flutter_gram_app/widgets/story_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> posts = [
      {
        "username": "Vijay",
        "profile": "images/vijay1.jpg",
        "post": "images/post1.jpg",
      },
      {
        "username": "Thalapathy",
        "profile": "images/vijay2.jpg",
        "post": "images/post2.jpg",
      },
      {
        "username": "CMVijay",
        "profile": "images/vijay3.jpg",
        "post": "images/post3.jpg",
      },
      {
        "username": "TVK FOR TN",
        "profile": "images/vijay4.jpg",
        "post": "images/post4.jpg",
      },
      {
        "username": "CM OF TN",
        "profile": "images/vijay5.jpg",
        "post": "images/post5.jpg",
      },
      {
        "username": "Flutter",
        "profile": "images/flutter.jpg",
        "post": "images/flutter1.jpg",
      },
      {
        "username": "Mobile Developers",
        "profile": "images/apps.jpg",
        "post": "images/postapp2.jpg",
      },
      {
        "username": "APP Engineer",
        "profile": "images/vijay3.jpg",
        "post": "images/office.jpg",
      },
      {
        "username": "TVK FOR TN",
        "profile": "images/vijay4.jpg",
        "post": "images/test.jpg",
      },
      {
        "username": "CM OF TN",
        "profile": "images/vijay5.jpg",
        "post": "images/flutter.jpg",
      },
    ];
    return CustomScrollView(
      slivers: [
        const CustomAppBar(),
        SliverToBoxAdapter(
          child: Column(children: [
            SizedBox(
              height: 110,
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return Container(
                    //color: Colors.red,
                    width: 80,
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: index == 0
                        ? const AddStoryScreen()
                        : const StoryWidget(),
                  );
                },
                itemCount: 10,
                scrollDirection: Axis.horizontal,
              ),
            ),
            const Divider(
              height: 1,
            ),
          ]),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              return PostScreen(
                username: posts[index]["username"]!,
                profileImage: posts[index]["profile"]!,
                postImage: posts[index]["post"]!,
              );
            },
            childCount: posts.length,
          ),
        )
      ],
    );
  }
}
