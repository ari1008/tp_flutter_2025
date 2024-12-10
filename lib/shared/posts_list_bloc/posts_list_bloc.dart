import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../app_exception.dart';
import '../../model/post.dart';
import '../../services/posts_repository/posts_repository.dart';

part 'posts_list_event.dart';

part 'posts_list_state.dart';

class PostsListBloc extends Bloc<PostsListEvent, PostsListState> {
  final PostsRepository postsRepository;

  PostsListBloc({required this.postsRepository})
      : super(const PostsListState()) {
    on<GetAllPostEvent>(_onGetPosts);
  }

  void _onGetPosts(GetAllPostEvent event, Emitter<PostsListState> emit) async {
    emit(state.copyWith(status: PostsListStatus.loading));
    try {
      final posts = await postsRepository.getAllPosts();
      emit(state.copyWith(status: PostsListStatus.success, posts: posts));
    } on AppException catch (error) {
      emit(state.copyWith(status: PostsListStatus.error, exception: error));
    }
  }
}
