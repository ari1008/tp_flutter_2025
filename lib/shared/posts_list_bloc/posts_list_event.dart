part of 'posts_list_bloc.dart';

@immutable
sealed class PostsListEvent {
  const PostsListEvent();
}

class GetAllPostEvent extends PostsListEvent {

  const GetAllPostEvent();
}
