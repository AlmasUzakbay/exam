import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_education/data/repository/firebase_repository.dart';
import 'package:flutter_education/data/repository/post_repository.dart';
import 'package:flutter_education/firebase_options.dart';
import 'package:flutter_education/generated/codegen_loader.g.dart';
import 'package:flutter_education/presentation/bloc/auth/auth_bloc.dart';
import 'package:flutter_education/presentation/bloc/post/post_bloc.dart';
import 'package:flutter_education/presentation/bloc/post/post_event.dart';
import 'package:flutter_education/presentation/pages/DrawerMenu.dart';
import 'package:flutter_education/presentation/pages/LogIn.dart';
import 'package:flutter_education/presentation/pages/News.dart';
import 'package:flutter_education/presentation/pages/Register.dart';
import 'package:flutter_education/presentation/pages/User.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_education/presentation/pages/splash.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await EasyLocalization.ensureInitialized();
  final Dio dio = Dio();
  final PostApi postApi = PostApi(dio);

  runApp(
    EasyLocalization(
      supportedLocales: [Locale('en'), Locale('kk'), Locale('ru')],
      path: 'assets/translation',
      fallbackLocale: Locale('en'),
      assetLoader: CodegenLoader(),
      child: MyApp(postApi: postApi),
    ),
  );
}

class MyApp extends StatelessWidget {
  final PostApi postApi;

  MyApp({required this.postApi});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        RepositoryProvider(
          create: (context) =>
              AuthenticationRepository(firebaseAuth: FirebaseAuth.instance),
        ),
        BlocProvider(
          create: (context) => AuthenticationBloc(
              authRepository: context.read<AuthenticationRepository>()),
        ),
        BlocProvider(
          create: (context) {
            final PostBloc postBloc = PostBloc(postApi: postApi);
            postBloc.add(LoadPosts());
            return postBloc;
          },
        ),
      ],
      child: MaterialApp(
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        initialRoute: '/',
        routes: {
          '/': (context) => SplashScreen(),
          '/register': (context) => RegisterPage(),
          '/login': (context) => LoginPage(),
          '/userProfile': (context) => UserProfilePage(),
          '/drawmenu': (context) => DrawMenu(),
          '/news': (context) => PostsPage(),
        },
      ),
    );
  }
}
