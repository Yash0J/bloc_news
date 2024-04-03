import 'package:flutter/material.dart';
// import 'package:bloc_news/bloc/news_states.dart';
import 'package:bloc_news/bloc/news_bloc.dart';
import 'package:bloc_news/repositories/news_repository.dart';
import 'package:bloc_news/views/app/SplashScreen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

void main() {
  runApp(const MyApp() as Widget);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
      builder: (context, orientation, screenType) => BlocProvider<NewsBloc>(
        create: (context) => NewsBloc(newsRepository: NewsRepository()),
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
