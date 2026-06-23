import 'package:flutter/material.dart';

class StoryWidget extends StatefulWidget {
  const StoryWidget({super.key});

  @override
  State<StoryWidget> createState() => _StoryWidgetState();
}

class _StoryWidgetState extends State<StoryWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(1),
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.red, Colors.orange, Colors.yellow.shade600]),
              border: Border.all(width: 2, color: Colors.transparent),
              borderRadius: BorderRadius.circular(50)),
          child: const CircleAvatar(
            backgroundColor: Colors.white,
            radius: 32,
            child: CircleAvatar(
              backgroundColor: Colors.black,
              radius: 30,
            ),
          ),
        ),
        // const Spacer(),
        const SizedBox(height: 5),

        const Text(
          'Yuvaraj',
          // maxLines: 1,
          style: TextStyle(
            fontWeight: FontWeight.w400,
            overflow: TextOverflow.ellipsis,
          ),
        )
      ],
    );
  }
}
