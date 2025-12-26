import 'package:flutter/material.dart';
import '../models/user_model.dart';

class StoryWidget extends StatelessWidget {
  final User user;
  final bool isViewed;

  const StoryWidget({
    super.key,
    required this.user,
    required this.isViewed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        image: user.profileImage.isNotEmpty
            ? DecorationImage(
          image: NetworkImage(user.profileImage),
          fit: BoxFit.cover,
        )
            : null,
        gradient: isViewed
            ? LinearGradient(
          colors: [Colors.grey[300]!, Colors.grey[400]!],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        )
            : LinearGradient(
          colors: [Colors.blue[400]!, Colors.purple[400]!],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Stack(
        children: [
          // Gradient overlay
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  Colors.black.withOpacity(0.3),
                  Colors.transparent,
                ],
              ),
            ),
          ),
          // User profile image
          Positioned(
            top: 8,
            left: 8,
            child: Container(
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Colors.white,
                  width: 2,
                ),
              ),
              child: CircleAvatar(
                radius: 16,
                backgroundImage: NetworkImage(user.profileImage),
              ),
            ),
          ),
          // User name
          Positioned(
            bottom: 8,
            left: 8,
            right: 8,
            child: Text(
              user.name.split(' ')[0], // First name only
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}