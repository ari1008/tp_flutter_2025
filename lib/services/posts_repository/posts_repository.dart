import 'package:al1_2024_aristide_fumo_tp/services/posts_data_source/posts_data_source.dart';

import '../../model/post.dart';
import '../local_posts_data_source/local_posts_data_source.dart';

class PostsRepository {
  final PostsDataSource postsDataSource;
  final LocalPostsDataSource localPostsDataSource;

  PostsRepository({
    required this.postsDataSource,
    required this.localPostsDataSource,
  });

  Future<List<Post>> getAllPosts() async {
    try {
      final posts = await postsDataSource.getAllPosts();
      return posts;
    } catch (error) {
      return localPostsDataSource.getAllPosts();
    }
  }

  Future<void> addPost(Post post) async {
    await postsDataSource.addPost(post);
    localPostsDataSource.addPost(post);
  }

  Future<void> updatePost(Post post) async {
    await postsDataSource.updatePost(post);
    localPostsDataSource.updatePost(post);
  }


  Future<Post> getPost(int id) async {
    return postsDataSource.getPost(id);
  }


}
