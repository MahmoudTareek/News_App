import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/cubit/cubit.dart';
import 'package:news_app/modules/onBoarding/on_boarding_screen.dart';
import 'package:news_app/shared/network/dio_helper.dart';

void main() {
  DioHelper.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsFlutterBinding.ensureInitialized();
    return MultiBlocProvider(
      providers: [
        BlocProvider<NewsCubit>(create: (context) => NewsCubit()..getAllNews()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: OnBoardingScreen(),
      ),
    );
  }
}
