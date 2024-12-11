import 'package:al1_2024_aristide_fumo_tp/services/posts_data_source/posts_data_source.dart';

import '../../model/post.dart';

class FakeDataSource extends PostsDataSource {

  final List<Post> posts = [
    /*Post(id: 1, title: 'Post 1', body: 'Body 1'),
    Post(id: 2, title: 'Post 2', body: 'Body 2'),
    Post(id: 3, title: 'Post 3', body: 'Body 3'),*/
  ];

  @override
  Future<List<Post>> getAllPosts() async {
    await Future.delayed(const Duration(seconds: 1));
    return posts;
  }

  @override
  Future<void> addPost(Post post) {
    return Future.delayed(const Duration(seconds: 1), () {
      int? maxId = posts.isEmpty
          ? null
          : posts
          .where((post) => post.id != null)
          .reduce((a, b) => a.id! > b.id! ? a : b)
          .id;
      final postCreate = post.copyWith(id: maxId != null ? maxId + 1 : 1);
      posts.add(postCreate);
    });
  }


  @override
  Future<Post> getPost(int id) {
    return Future.delayed(const Duration(seconds: 1), () {
      return posts.firstWhere((element) => element.id == id);
    });
  }


  @override
  Future<void> updatePost(Post post) {
    return Future.delayed(const Duration(seconds: 1), () {
      final index = posts.indexWhere((element) => element.id == post.id);
      posts[index] = post;
    });
  }



}
