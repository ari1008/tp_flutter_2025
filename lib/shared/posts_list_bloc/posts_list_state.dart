part of 'posts_list_bloc.dart';

enum PostsListStatus { initial, loading, success, error, }

class PostsListState {
  final List<Post> posts;
  final AppException? exception;
  final PostsListStatus status;

  const PostsListState({
    this.posts = const <Post>[],
    this.exception,
    this.status = PostsListStatus.initial,
  });

  PostsListState copyWith({
    List<Post>? posts,
    AppException? exception,
    PostsListStatus? status,
  }) {
    return PostsListState(
      posts: posts ?? this.posts,
      exception: exception,
      status: status ?? this.status,
    );
  }
}