import 'package:al1_2024_aristide_fumo_tp/posts_screen/post_create/post_create.dart';
import 'package:al1_2024_aristide_fumo_tp/shared/posts_list_bloc/posts_list_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../app_exception.dart';
import '../model/post.dart';
import '../shared/post_bloc/post_bloc.dart';
import '../posts_screen/post_detail_screen/post_detail_screen.dart';

class PostsScreen extends StatefulWidget {
  const PostsScreen({super.key});

  @override
  State<PostsScreen> createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  @override
  void initState() {
    super.initState();
    _getAllPosts();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _getAllPosts();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<PostBloc, PostState>(
          listener: (context, state) {
            if (state.status == PostStatus.error) {
              _showSnackBar(context, state.exception);
            } else if (state.status == PostStatus.success) {
              _getAllPosts();
            }
          },
        ),
        BlocListener<PostsListBloc, PostsListState>(
          listener: (context, state) {
            if (state.status == PostsListStatus.error) {
              _showSnackBar(context, state.exception);
            }
          },
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Posts'),
        ),
        body: BlocBuilder<PostsListBloc, PostsListState>(
          builder: (context, state) {
            return switch (state.status) {
              PostsListStatus.initial ||
              PostsListStatus.loading =>
                  _buildLoading(context),
              PostsListStatus.error =>
                  _buildError(context, state.exception as Exception),
              PostsListStatus.success =>
                  _buildSuccess(context, state.posts),
            };
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _onAddPost(context),
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  void _getAllPosts() {
    final postsListBloc = BlocProvider.of<PostsListBloc>(context);
    postsListBloc.add(const GetAllPostEvent());
  }

  Widget _buildLoading(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildError(BuildContext context, Exception exception) {
    return Center(
      child: Text('Error: $exception'),
    );
  }

  Widget _buildSuccess(BuildContext context, List<Post> posts) {
    return ListView.builder(
      itemCount: posts.length,
      itemBuilder: (context, index) {
        final post = posts[index];
        return ListTile(
          title: Text(post.title),
          subtitle: Text(post.body),
          onTap: () => _onPostTapped(context, post),
        );
      },
    );
  }

  void _onPostTapped(BuildContext context, Post post) {
    PostDetailScreen.navigateTo(context, post);
  }

  void _onAddPost(BuildContext context) {
    CreatePostScreen.navigateTo(context);
  }

  void _showSnackBar(BuildContext context, AppException? exception) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Erreur lors de l\'ajout du produit dans le panier: ${exception ?? 'Inconnue'}',
        ),
      ),
    );
  }
}