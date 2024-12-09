part of 'post_bloc.dart';

enum PostStatus {
  initial,
  loading,
  error,
  addingPost,
  success,
  updatingPost,
  successGetPosts,
}

class PostState {
  final List<Post> posts;
  final AppException? exception;
  final PostStatus status;

  const PostState({
    this.posts = const <Post>[],
    this.exception,
    this.status = PostStatus.initial,
  });

  PostState copyWith({
    List<Post>? posts,
    AppException? exception,
    PostStatus? status,
  }) {
    return PostState(
      posts: posts ?? this.posts,
      exception: exception,
      status: status ?? this.status,
    );
  }
}
