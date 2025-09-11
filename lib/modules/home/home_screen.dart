import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/cubit/cubit.dart';
import 'package:news_app/cubit/states.dart';
import 'package:news_app/shared/components.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedCategory = 'all';
  final List<String> categories = [
    'all',
    'business',
    'entertainment',
    'general',
    'health',
    'science',
    'sports',
    'technology',
  ];

  @override
  void initState() {
    super.initState();
    NewsCubit.get(context).getAllNews();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = NewsCubit.get(context);
        var list = cubit.allNews;
        return CustomRefreshIndicator(
          onRefresh: () async {
            if (selectedCategory == 'all') {
              cubit.getAllNews();
            } else {
              selectedCategory = 'all';
              cubit.getAllNews();
            }
          },
          builder:
              (
                BuildContext context,
                Widget child,
                IndicatorController controller,
              ) {
                return AnimatedBuilder(
                  animation: controller,
                  builder: (BuildContext context, _) {
                    return Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        if (!controller.isIdle)
                          Positioned(
                            top: 35.0 * controller.value - 30,
                            child: SizedBox(
                              height: 30,
                              width: 30,
                              child: CircularProgressIndicator(
                                strokeWidth: 2.0,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  Colors.blue,
                                ),
                                value: controller.isLoading
                                    ? null
                                    : controller.value,
                              ),
                            ),
                          ),
                        Transform.translate(
                          offset: Offset(0, 35.0 * controller.value),
                          child: child,
                        ),
                      ],
                    );
                  },
                );
              },
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 25.0),
                  child: Text(
                    "Latest",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  height: 40,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.only(left: 8.0),
                    itemBuilder: (context, index) {
                      final category = categories[index];
                      final isSelected = category == selectedCategory;
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedCategory = category;
                          });

                          if (category == 'all') {
                            cubit.getAllNews();
                          } else {
                            cubit.getNewsByCategory(category);
                          }
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: isSelected
                                    ? Colors.blue
                                    : Colors.transparent,
                                width: 3.0,
                              ),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              category.toUpperCase(),
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: isSelected
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => SizedBox(width: 3.0),
                    itemCount: categories.length,
                  ),
                ),
                SizedBox(height: 10),
                articleBuilder(list, context),
              ],
            ),
          ),
        );
      },
    );
  }
}
