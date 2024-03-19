import 'package:bloc_news/bloc/news_states.dart';
import 'package:bloc_news/bloc/news_bloc.dart';
import 'package:bloc_news/repositories/news_repository.dart';
import 'package:bloc_news/views/SplashScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
      builder: (context, orientation, screenType) => MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => NewsBloc(
              initialState: NewsInitState(),
              newsRepository: NewsRepository(),
            ),
          ),
        ],
        child: MaterialApp(
          title: 'News App',
          theme: ThemeData(
            colorScheme: const ColorScheme.dark(),
            textTheme: GoogleFonts.robotoTextTheme(Theme.of(context).textTheme),
          ),
          home: const SplashScreen(),
        ),
      ),
    );
  }
}
