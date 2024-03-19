import 'package:bloc_news/bloc/news_states.dart';
import 'package:bloc_news/bloc/news_events.dart';
import 'package:bloc_news/modals/article_modal.dart';
import 'package:bloc_news/repositories/news_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewsBloc extends Bloc<NewsEvents, NewsStates> {
  NewsRepository newsRepository;
  NewsBloc({
    required NewsStates initialState,
    required this.newsRepository,
  }) : super(initialState) {
    add(StartEvent()); // Add StartEvent on bloc creation
  }

  @override
  Stream<NewsStates> mapEventToState(NewsEvents event) async* {
    if (event is StartEvent) {
      try {
        List<ArticleModal> articleList = [];
        yield NewsLoadingState();
        articleList = await newsRepository.fetchNews();
        yield NewsLoadedState(articleList: articleList);
      } catch (_newsError) {
        yield NewsErrorState(errorMEssage: _newsError.toString());
      }
    }
  }
}

// class NewsBloc extends Bloc<NewsEvents, NewsStates> {
//   final NewsRepository newsRepository;

//   NewsBloc({
//     required NewsStates initialState,
//     required this.newsRepository,
//   }) : super(initialState);

//   Stream<NewsStates> mapEventToState(NewsEvents event) async* {
//     if (event is StartEvent) {
//       try {
//         List<ArticleModal> articleList = await newsRepository.fetchNews();
//         yield NewsLoadedState(articleList: articleList);
//       } catch (error) {
//         yield NewsErrorState(errorMEssage: error.toString());
//       }
//     }
//   }
// }

