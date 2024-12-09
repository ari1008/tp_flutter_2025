import '../../model/post.dart';
import '../posts_data_source/posts_data_source.dart';

abstract class LocalPostsDataSource extends PostsDataSource {

  @override
  Future<List<Post>> getAllPosts();

  @override
  Future<void> addPost(Post post);

  @override
  Future<void> updatePost(Post post);

  @override
  Future<Post> getPost(int id);
}