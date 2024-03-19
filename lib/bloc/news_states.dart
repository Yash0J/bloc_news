import 'package:equatable/equatable.dart';

import '../modals/article_modal.dart';

class NewsStates extends Equatable {
  const NewsStates();
  @override
  List<Object> get props => [];
}

class NewsInitState extends NewsStates {}

class NewsLoadingState extends NewsStates {}

class NewsLoadedState extends NewsStates {
  final List<ArticleModal> articleList;
  const NewsLoadedState({required this.articleList});
}

class NewsErrorState extends NewsStates {
  final String errorMEssage;
  const NewsErrorState({required this.errorMEssage});
}
