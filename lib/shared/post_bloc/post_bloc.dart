import 'package:al1_2024_aristide_fumo_tp/app_exception.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../model/post.dart';
import '../../services/posts_repository/posts_repository.dart';

part 'post_event.dart';

part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final PostsRepository postsRepository;

  PostBloc({required this.postsRepository}) : super(const PostState()) {
    on<GetPostsEvent>(_onGetPosts);
    on<AddPostEvent>(_onAddPost);
    on<UpdatePostEvent>(_onUpdatePost);
  }

  void _onGetPosts(GetPostsEvent event, Emitter<PostState> emit) async {
    emit(state.copyWith(status: PostStatus.loading));
    try {
      final posts = await postsRepository.getAllPosts();
      emit(state.copyWith(status: PostStatus.successGetPosts, posts: posts));
    } on AppException catch (error) {
      emit(state.copyWith(status: PostStatus.error, exception: error));
    }
  }

  void _onAddPost(AddPostEvent event, Emitter<PostState> emit) async {
    emit(state.copyWith(status: PostStatus.loading));
    try {
      await postsRepository.addPost(event.post);
      emit(state.copyWith(status: PostStatus.addingPost));
    } on AppException catch (error) {
      emit(state.copyWith(status: PostStatus.error, exception: error));
    }
  }

  void _onUpdatePost(UpdatePostEvent event, Emitter<PostState> emit) async {
    emit(state.copyWith(status: PostStatus.loading));
    try {
      await Future.delayed(const Duration(seconds: 1));
      await postsRepository.updatePost(event.post);
      emit(state.copyWith(status: PostStatus.updatingPost));
    } on AppException catch (error) {
      emit(state.copyWith(status: PostStatus.error, exception: error));
    }
  }
}
