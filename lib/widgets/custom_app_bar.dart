import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.white,
      pinned: true,
      elevation: 0,
      title: const Text(
        'Instagram',
        style: TextStyle(
          color: Colors.black,
          fontSize: 32,
          fontFamily: 'Billabong',
        ),
      ),
      leading: IconButton(
        onPressed: () {},
        icon: const Icon(
          Icons.add,
          color: Colors.black,
          size: 30,
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.favorite_border,
            color: Colors.black,
            size: 28,
          ),
        ),
      ],
    );
  }
}
