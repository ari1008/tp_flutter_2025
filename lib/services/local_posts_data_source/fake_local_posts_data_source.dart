
import 'package:al1_2024_aristide_fumo_tp/model/post.dart';

import 'local_posts_data_source.dart';

class FakeLocalPostsDataSource implements LocalPostsDataSource {

  @override
  Future<void> addPost(Post post) {
    return Future.delayed(const Duration(seconds: 1), () {
      // posts.add(post);
    });
  }


  @override
  Future<List<Post>> getAllPosts() {
    return Future.delayed(const Duration(seconds: 1), () {
      return [];
    });
  }

  @override
  Future<Post> getPost(int id) {
    return Future.delayed(const Duration(seconds: 1), () {
      // return posts.firstWhere((element) => element.id == id);
      return Post(id: 1, title: 'Post 1', body: 'Body 1');
    });
  }

  @override
  Future<void> updatePost(Post post) {
    return Future.delayed(const Duration(seconds: 1), () {
      // final index = posts.indexWhere((element) => element.id == post.id);
      // posts[index] = post;
    });
  }
}