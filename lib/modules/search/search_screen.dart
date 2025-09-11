// search screen to search for news articles based on user keywords and display the results in a list format.
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/cubit/cubit.dart';
import 'package:news_app/cubit/states.dart';
import 'package:news_app/shared/components.dart';

class SearchScreen extends StatelessWidget {
  // Controller for the search input field
  var searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var list = NewsCubit.get(context).search;
        return Scaffold(
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                // Search input field with validation and onChange listener to fetch search results
                child: defaultFormField(
                  controller: searchController,
                  type: TextInputType.text,
                  // Fetch search results as user types in the search field
                  onChange: (value) {
                    NewsCubit.get(context).getSearch(value);
                    print(value);
                  },
                  // Validation to ensure search field is not empty
                  validate: (String value) {
                    if (value.isEmpty) {
                      return 'Search can\'t be empty';
                    }
                    return null;
                  },
                  label: 'Search',
                  prefix: Icons.search,
                  context: context,
                ),
              ),
              // Display search results in a list format using articleBuilder function from components.dart
              Expanded(child: articleBuilder(list, context, isSearch: true)),
            ],
          ),
        );
      },
    );
  }
}
