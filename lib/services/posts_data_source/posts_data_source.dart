import '../../model/post.dart';

abstract class PostsDataSource {
  Future<List<Post>> getAllPosts();

  Future<void> addPost(Post post);

  Future<void> updatePost(Post post);

  Future<Post> getPost(int id);
}