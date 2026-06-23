import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import 'login_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> profilePosts = [
      'images/post1.jpg',
      'images/post2.jpg',
      'images/post3.jpg',
      'images/post4.jpg',
      'images/post5.jpg',
      'images/reels.jpeg',
      'images/vijay1.jpg',
      'images/vijay2.jpg',
      'images/vijay3.jpg',
      'images/vijay4.jpg',
      'images/vijay5.jpg',
      'images/profile.jpg',
    ];
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'just_call_me_yuvi_',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.logout,
              color: Colors.red,
            ),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text('Logout'),
                    content: const Text(
                      'Are you sure you want to logout?',
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Cancel'),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          await Hive.box('users').put(
                            'isLoggedIn',
                            false,
                          );

                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const InstagramLoginScreen(),
                            ),
                            (route) => false,
                          );
                        },
                        child: const Text('Logout'),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            const CircleAvatar(
              radius: 45,
              backgroundImage: NetworkImage(
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRufgpbhv968acPDGlPv-9g9a73QL5UPBj3JA&s',
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Yuvaraj P',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              'Flutter Developer',
              style: TextStyle(
                color: Colors.grey.shade700,
              ),
            ),
            const SizedBox(height: 20),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _ProfileCount(
                  count: '10',
                  title: 'Posts',
                ),
                _ProfileCount(
                  count: '500',
                  title: 'Followers',
                ),
                _ProfileCount(
                  count: '300',
                  title: 'Following',
                ),
              ],
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () {},
                  child: const Text('Edit Profile'),
                ),
              ),
            ),
            const SizedBox(height: 20),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: profilePosts.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 2,
                mainAxisSpacing: 2,
              ),
              itemBuilder: (context, index) {
                return Image.asset(
                  profilePosts[index],
                  fit: BoxFit.cover,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _ProfileCount extends StatelessWidget {
  final String count;
  final String title;

  const _ProfileCount({
    required this.count,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          count,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        Text(title),
      ],
    );
  }
}
