import 'package:flutter/material.dart';

import '../services/auth_service.dart';
import '../models/user_model.dart';
import '../widgets/post_widget.dart';
import '../widgets/story_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  // Dummy Data
  final List<User> _stories = [
    User(
      id: '1',
      name: 'anna abdiyu',
      email: 'anna@example.com',
      profileImage: 'https://randomuser.me/api/portraits/men/1.jpg',
      friendsCount: 342,
      mutualFriends: ['Alice', 'Bob'],
    ),
    User(
      id: '2',
      name: 'alazar zemene',
      email: 'alazar@example.com',
      profileImage: 'https://randomuser.me/api/portraits/women/2.jpg',
      friendsCount: 256,
      mutualFriends: ['Alice'],
    ),
    User(
      id: '3',
      name: 'amanuel wubishet',
      email: 'amanuelw@example.com',
      profileImage: 'https://randomuser.me/api/portraits/men/3.jpg',
      friendsCount: 128,
      mutualFriends: ['Bob', 'Charlie'],
    ),
    User(
      id: '4',
      name: 'amanuel melkamu',
      email: 'amanuel@example.com',
      profileImage: 'https://randomuser.me/api/portraits/women/4.jpg',
      friendsCount: 567,
      mutualFriends: ['Alice', 'David'],
    ),
  ];

  final List<Post> _posts = [
    Post(
      id: '1',
      user: User(
        id: '1',
        name: 'abebe bekele',
        email: 'abebe@example.com',
        profileImage: 'https://randomuser.me/api/portraits/men/1.jpg',
        friendsCount: 342,
        mutualFriends: [],
      ),
      content: 'Beautiful day for a hike! 🏞️ #nature #outdoors',
      imageUrl: 'https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=600',
      timestamp: DateTime.now().subtract(const Duration(hours: 2)),
      likes: 245,
      comments: 42,
      isLiked: true,
    ),
    Post(
      id: '2',
      user: User(
        id: '2',
        name: 'Jane Smith',
        email: 'jane@example.com',
        profileImage: 'https://randomuser.me/api/portraits/women/2.jpg',
        friendsCount: 256,
        mutualFriends: [],
      ),
      content: 'Just finished my Flutter project! So excited about it. #flutter #coding',
      timestamp: DateTime.now().subtract(const Duration(hours: 5)),
      likes: 189,
      comments: 31,
      isLiked: false,
    ),
    Post(
      id: '3',
      user: User(
        id: '3',
        name: 'Mike Johnson',
        email: 'mike@example.com',
        profileImage: 'https://randomuser.me/api/portraits/men/3.jpg',
        friendsCount: 128,
        mutualFriends: [],
      ),
      content: 'Great food with great friends! 🍕',
      imageUrl: 'https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?w=600',
      timestamp: DateTime.now().subtract(const Duration(days: 1)),
      likes: 89,
      comments: 12,
      isLiked: true,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('facebook'),
        titleTextStyle: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: Colors.blue[800],
          letterSpacing: -1.2,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.message),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await AuthService().signOut();
              if (context.mounted) {
                Navigator.of(context).pushNamedAndRemoveUntil('/login', (route) => false);
              }
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Create Post Card
            Container(
              margin: const EdgeInsets.all(12),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundImage: NetworkImage(
                      'https://randomuser.me/api/portraits/men/32.jpg',
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => _showCreatePostDialog(context),
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: Text(
                          "What's on your mind?",
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.photo_library, color: Colors.green),
                    onPressed: () {},
                  ),
                ],
              ),
            ),

            // Stories Section
            Container(
              height: 200,
              padding: const EdgeInsets.all(12),
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      'Stories',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Expanded(
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: _stories.length + 1, // +1 for "Add Story"
                      itemBuilder: (context, index) {
                        if (index == 0) {
                          return _buildAddStoryCard();
                        }
                        return StoryWidget(
                          user: _stories[index - 1],
                          isViewed: false,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),

            // Posts
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _posts.length,
              itemBuilder: (context, index) {
                return PostWidget(post: _posts[index]);
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Friends',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.video_library),
            label: 'Video',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notifications',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu),
            label: 'Menu',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        onTap: _onItemTapped,
      ),
    );
  }

  Widget _buildAddStoryCard() {
    return Container(
      width: 100,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Column(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
              ),
              child: Icon(
                Icons.add_circle,
                size: 40,
                color: Colors.blue[600],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Text(
              'Create\nstory',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey[800],
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showCreatePostDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Create Post'),
          content: SizedBox(
            height: 200,
            child: Column(
              children: [
                TextField(
                  maxLines: 4,
                  decoration: InputDecoration(
                    hintText: "What's on your mind?",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.photo),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: const Icon(Icons.videocam),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: const Icon(Icons.location_on),
                      onPressed: () {},
                    ),
                  ],
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Post'),
            ),
          ],
        );
      },
    );
  }
}