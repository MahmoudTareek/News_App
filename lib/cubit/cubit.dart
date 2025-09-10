import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/cubit/states.dart';
import 'package:news_app/modules/bookmarks/bookmarks_screen.dart';
import 'package:news_app/modules/explore/explore_screen.dart';
import 'package:news_app/modules/home/home_screen.dart';
import 'package:news_app/modules/profile/profile_screen.dart';
import 'package:news_app/modules/search/search_screen.dart';
import 'package:news_app/shared/network/dio_helper.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(NewsInitialState());

  static NewsCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

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

  void changeBottomNavBar(int index) {
    currentIndex = index;

    // if(index == 1)
    //   getSports();
    // if(index == 2)
    //   getScience();

    emit(NewsBottomNavState());
  }

  List<dynamic> business = [];

  void getBusiness() {
    emit(NewsGetBusinessLoadingState());
    DioHelper.getData(
          url: 'v2/everything',
          query: {'q': '*', 'apiKey': 'e55351d11831407784ecf1edc1673e7b'},
        )
        .then((value) {
          business = value.data['articles'];
          print(business[0]['title']);
          emit(NewsGetBusinessSuccessState());
        })
        .catchError((error) {
          print(error.toString());
          emit(NewsGetBusinessErrorState(error.toString()));
        });
  }

  List<dynamic> sports = [];

  void getSports() {
    emit(NewsGetSportsLoadingState());

    if (sports.length == 0) {
      DioHelper.getData(
            url: 'v2/top-headlines',
            query: {
              'category': 'sports',
              'apiKey': 'e55351d11831407784ecf1edc1673e7b',
            },
          )
          .then((value) {
            // print(value.data['articles'][0]['title']);
            sports = value.data['articles'];
            print(sports[0]['title']);
            emit(NewsGetSportsSuccessState());
          })
          .catchError((error) {
            print(error.toString());
            emit(NewsGetSportsErrorState(error.toString()));
          });
    } else {
      emit(NewsGetSportsSuccessState());
    }
  }

  List<dynamic> science = [];

  void getScience() {
    emit(NewsGetScienceLoadingState());

    if (science.length == 0) {
      DioHelper.getData(
            url: 'v2/top-headlines',
            query: {
              'category': 'science',
              'apiKey': 'e55351d11831407784ecf1edc1673e7b',
            },
          )
          .then((value) {
            // print(value.data['articles'][0]['title']);
            science = value.data['articles'];
            print(science[0]['title']);
            emit(NewsGetScienceSuccessState());
          })
          .catchError((error) {
            print(error.toString());
            emit(NewsGetScienceErrorState(error.toString()));
          });
    } else {
      emit(NewsGetScienceSuccessState());
    }
  }

  List<dynamic> search = [];

  void getSearch(String value) {
    emit(NewsGetSearchLoadingState());

    DioHelper.getData(
          url: 'v2/everything',
          query: {'q': '$value', 'apiKey': 'e55351d11831407784ecf1edc1673e7b'},
        )
        .then((value) {
          // print(value.data['articles'][0]['title']);
          search = value.data['articles'];
          print(search[0]['title']);
          emit(NewsGetSearchSuccessState());
        })
        .catchError((error) {
          print(error.toString());
          emit(NewsGetSearchErrorState(error.toString()));
        });
  }
}
