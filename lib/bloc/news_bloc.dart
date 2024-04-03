import 'package:bloc_news/bloc/news_states.dart';
import 'package:bloc_news/bloc/news_events.dart';
import 'package:bloc_news/repositories/news_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewsBloc extends Bloc<NewsEvents, NewsStates> {
  final NewsRepository newsRepository;
  NewsBloc({required this.newsRepository}) : super(NewsInitState()) {
    on<StartEvent>(_fetchNews);
  }

  Future<void> _fetchNews(StartEvent event, Emitter<NewsStates> emit) async {
    try {
      emit(NewsLoadingState());
      final articleList = await newsRepository.fetchNews();
      emit(NewsLoadedState(articleList: articleList));
    } catch (e) {
      emit(NewsErrorState(errorMessage: e.toString()));
    }
  }
}
