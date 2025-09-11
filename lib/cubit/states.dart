// states for News App
abstract class NewsStates {}

class NewsInitialState extends NewsStates {}

class NewsBottomNavState extends NewsStates {}

class NewsGetAllNewsLoadingState extends NewsStates {}

class NewsGetAllNewsSuccessState extends NewsStates {}

class NewsGetAllNewsErrorState extends NewsStates {
  late final String error;

  NewsGetAllNewsErrorState(this.error);
}

class NewsGetSearchLoadingState extends NewsStates {}

class NewsGetSearchSuccessState extends NewsStates {}

class NewsGetSearchErrorState extends NewsStates {
  late final String error;

  NewsGetSearchErrorState(this.error);
}
