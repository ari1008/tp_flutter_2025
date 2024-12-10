import 'package:al1_2024_aristide_fumo_tp/shared/post_bloc/post_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/post.dart';
import '../../shared/posts_list_bloc/posts_list_bloc.dart';

class CreatePostScreen extends StatelessWidget {
  const CreatePostScreen({super.key});

  static Future<void> navigateTo(BuildContext context) {
    return Navigator.pushNamed(context, '/postCreate');
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController titleController = TextEditingController();
    final TextEditingController bodyController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    void submitPost() {
      final title = titleController.text.trim();
      final body = bodyController.text.trim();
      if (formKey.currentState!.validate()) {
        BlocProvider.of<PostBloc>(context).add(
          AddPostEvent(post: Post(title: title, body: body)),
        );
      }
    }

    return BlocListener<PostBloc, PostState>(
      listener: (context, state) {
        if (state.status == PostStatus.addingPost) {
          BlocProvider.of<PostsListBloc>(context).add(const GetAllPostEvent());
          Navigator.pop(context);
        } else if (state.status == PostStatus.error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.exception.toString())),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Create Post'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Title this Post',
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
                          children: const [
                            Text('Creating...'),
                            SizedBox(width: 8),
                            CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          ],
                        )
                            : const Text('Create Post'),
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
