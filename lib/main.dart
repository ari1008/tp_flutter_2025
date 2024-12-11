import 'package:al1_2024_aristide_fumo_tp/posts_screen/post_create/post_create.dart';
import 'package:al1_2024_aristide_fumo_tp/posts_screen/post_detail_screen/post_detail_screen.dart';
import 'package:al1_2024_aristide_fumo_tp/posts_screen/post_update/post_update.dart';
import 'package:al1_2024_aristide_fumo_tp/posts_screen/posts_screen.dart';
import 'package:al1_2024_aristide_fumo_tp/services/local_posts_data_source/fake_local_posts_data_source.dart';
import 'package:al1_2024_aristide_fumo_tp/services/posts_data_source/fake_data_source.dart';
import 'package:al1_2024_aristide_fumo_tp/services/posts_repository/posts_repository.dart';
import 'package:al1_2024_aristide_fumo_tp/shared/post_bloc/post_bloc.dart';
import 'package:al1_2024_aristide_fumo_tp/shared/posts_list_bloc/posts_list_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'model/post.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
        create: (context) => PostsRepository(
              localPostsDataSource: FakeLocalPostsDataSource(),
              postsDataSource: FakeDataSource(),
            ),
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => PostBloc(
                postsRepository: context.read<PostsRepository>(),
              ),
            ),
            BlocProvider(
              create: (context) => PostsListBloc(
                postsRepository: context.read<PostsRepository>(),
              ),
            ),
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            routes: {
              '/': (context) => const PostsScreen(),
              '/postDetail': (context) => PostDetailScreen(
                    post: ModalRoute.of(context)!.settings.arguments as Post,
                  ),
              '/postCreate': (context) => const CreatePostScreen(),
              '/postUpdate': (context) => UpdatePostScreen(
                    post: ModalRoute.of(context)!.settings.arguments as Post,
                  ),
            },
            onGenerateRoute: (routeSettings) {
              Widget screen = Container(color: Colors.pink);
              final argument = routeSettings.arguments;
              switch (routeSettings.name) {
                case '/postDetail':
                  if (argument is Post) {
                    screen = PostDetailScreen(
                      post: argument,
                    );
                  }
                  break;
              }

              return MaterialPageRoute(builder: (context) => screen);
            },
          ),
        ));
  }
}
