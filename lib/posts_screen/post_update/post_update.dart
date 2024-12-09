import 'package:al1_2024_aristide_fumo_tp/posts_screen/post_detail_screen/post_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../main.dart';
import '../../model/post.dart';
import '../../shared/post_bloc/post_bloc.dart';

class UpdatePostScreen extends StatelessWidget {
  final Post post;

  const UpdatePostScreen({super.key, required this.post});

  static Future<void> navigateTo(BuildContext context, Post post) {
    return Navigator.pushNamed(context, '/postUpdate', arguments: post);
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController titleController = TextEditingController(text: post.title);
    final TextEditingController bodyController = TextEditingController(text: post.body);
    final formKey = GlobalKey<FormState>();



    void submitPost() {
      final title = titleController.text.trim();
      final body = bodyController.text.trim();
      final updatedPost = post.copyWith(title: title, body: body);
      BlocProvider.of<PostBloc>(context).add(
        UpdatePostEvent(post: updatedPost),
      );
      MyApp.navigateTo(context);
      //PostDetailScreen.navigateTo(context, updatedPost);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Post'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Titre du Post',
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
                child: ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      submitPost();
                    }
                  },
                  child: const Text('Update le Post'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}