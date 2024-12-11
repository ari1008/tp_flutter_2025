import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../model/post.dart';
import '../../shared/post_bloc/post_bloc.dart';
import '../posts_screen.dart';

class UpdatePostScreen extends StatelessWidget {
  final Post post;

  const UpdatePostScreen({super.key, required this.post});

  static Future<void> navigateTo(BuildContext context, Post post) {
    return Navigator.pushNamed(context, '/postUpdate', arguments: post);
  }

  static Future<void> navigateReplacementTo(BuildContext context, Post post) {
    return Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => UpdatePostScreen(post: post),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController titleController =
    TextEditingController(text: post.title);
    final TextEditingController bodyController =
    TextEditingController(text: post.body);
    final formKey = GlobalKey<FormState>();

    void submitPost() {
      final title = titleController.text.trim();
      final body = bodyController.text.trim();
      final updatedPost = post.copyWith(title: title, body: body);
      context.read<PostBloc>().add(UpdatePostEvent(post: updatedPost));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Post'),
      ),
      body: BlocListener<PostBloc, PostState>(
        listener: (context, state) {
          if (state.status == PostStatus.updatingPost) {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const PostsScreen()),
                  (Route<dynamic> route) => false,
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Title of the Post',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: titleController,
                  decoration: InputDecoration(
                    hintText: 'Enter the title',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'The title is required.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                const Text(
                  'Content of the Post',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: bodyController,
                  maxLines: 5,
                  decoration: InputDecoration(
                    hintText: 'Enter the content',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'The content is required.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: BlocBuilder<PostBloc, PostState>(
                    builder: (context, state) {
                      return ElevatedButton(
                        onPressed: state.status == PostStatus.loading
                            ? null
                            : () {
                          if (formKey.currentState!.validate()) {
                            submitPost();
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: state.status == PostStatus.loading
                              ? Colors.grey
                              : null,
                        ),
                        child: state.status == PostStatus.loading
                            ? const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Updating...'),
                            SizedBox(width: 8),
                            CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          ],
                        )
                            : const Text('Update Post'),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
