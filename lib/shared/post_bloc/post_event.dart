part of 'post_bloc.dart';

@immutable
sealed class PostEvent {
  const PostEvent();
}

class AddPostEvent extends PostEvent {
  final Post post;

  const AddPostEvent({required this.post});
}

class UpdatePostEvent extends PostEvent {
  final Post post;

  const UpdatePostEvent({
    required this.post,
  });
}
