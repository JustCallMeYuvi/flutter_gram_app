import 'package:flutter/material.dart';

class AddStoryScreen extends StatelessWidget {
  const AddStoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Stack(
          children: [
            const CircleAvatar(
              radius: 33,
              backgroundImage: NetworkImage(
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRufgpbhv968acPDGlPv-9g9a73QL5UPBj3JA&s',
              ),
            ),
            Positioned(
              top: 40,
              left: 40,
              child: Container(
                height: 25,
                width: 25,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    color: Colors.white,
                    width: 3,
                  ),
                ),
                child: IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {},
                  icon: const Icon(
                    Icons.add,
                    size: 15,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 5), 
        const Text(
          'Your Story',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}