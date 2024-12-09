import 'package:flutter/material.dart';

import '../../model/post.dart';
import '../post_update/post_update.dart';

class PostDetailScreen extends StatelessWidget {
  final Post post;

  // Méthode statique pour la navigation vers cet écran
  static Future<void> navigateTo(BuildContext context, Post post) {
    return Navigator.pushNamed(context, '/postDetail', arguments: post);
  }

  const PostDetailScreen({
    super.key,
    required this.post,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(post.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            Text(
              post.title,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            const SizedBox(height: 10),
            Text(
              post.body,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _onAddPost(context, post),
        child: const Icon(Icons.abc),
      ),
    );
  }

  void _onAddPost(BuildContext context, Post post) {
    UpdatePostScreen.navigateTo(context, post);
  }
}
