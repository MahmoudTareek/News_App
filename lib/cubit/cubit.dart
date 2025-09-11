//Cubit page for managing the state of the app and fetching functions. It uses the Dio package for network requests and Fluttertoast for displaying messages.
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/cubit/states.dart';
import 'package:news_app/modules/bookmarks/bookmarks_screen.dart';
import 'package:news_app/modules/home/home_screen.dart';
import 'package:news_app/modules/profile/profile_screen.dart';
import 'package:news_app/modules/search/search_screen.dart';
import 'package:news_app/shared/network/dio_helper.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(NewsInitialState());

  static NewsCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  // Bottom Navigation Bar Items and corresponding screens for the app's main navigation
  List<BottomNavigationBarItem> bottomItems = [
    BottomNavigationBarItem(icon: Icon(Icons.home_rounded), label: 'Home'),
    BottomNavigationBarItem(
      icon: Icon(Icons.explore_outlined),
      label: 'Explore',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.bookmark_outline),
      label: 'Bookmarks',
    ),
    BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Profile'),
  ];

  List<Widget> screen = [
    HomeScreen(),
    SearchScreen(),
    BookmarksScreen(),
    ProfileScreen(),
  ];

  // Function to change the current index of the bottom navigation bar and emit a state change
  void changeBottomNavBar(int index) {
    currentIndex = index;
    emit(NewsBottomNavState());
  }

  // List to store all news articles fetched from the API
  List<dynamic> allNews = [];
  void getAllNews() {
    emit(NewsGetAllNewsLoadingState());
    DioHelper.getData(
          url: 'v2/everything',
          query: {'q': 'news', 'apiKey': '3765e44afd0b407d8ab3d80db9c6c037'},
        )
        .then((value) {
          print(value.data);
          allNews = value.data['articles'];
          emit(NewsGetAllNewsSuccessState());
        })
        .catchError((error) {
          print(error.toString());
          emit(NewsGetAllNewsErrorState(error.toString()));
        });
  }

  // List to store search results fetched from the API based on user keywords
  List<dynamic> search = [];
  void getSearch(String value) {
    emit(NewsGetSearchLoadingState());
    DioHelper.getData(
          url: 'v2/everything',
          query: {'q': '$value', 'apiKey': '3765e44afd0b407d8ab3d80db9c6c037'},
        )
        .then((value) {
          search = value.data['articles'];
          print(search[0]['title']);
          emit(NewsGetSearchSuccessState());
        })
        .catchError((error) {
          emit(NewsGetSearchErrorState(error.toString()));
        });
  }

  // Function to fetch news articles based on a specific category from the API
  void getNewsByCategory(String category) {
    emit(NewsGetAllNewsLoadingState());
    DioHelper.getData(
          url: 'v2/top-headlines',
          query: {
            'category': category,
            'country': 'us',
            'apiKey': '3765e44afd0b407d8ab3d80db9c6c037',
          },
        )
        .then((value) {
          allNews = value.data['articles'];
          emit(NewsGetAllNewsSuccessState());
        })
        .catchError((error) {
          emit(NewsGetAllNewsErrorState(error.toString()));
        });
  }
}
