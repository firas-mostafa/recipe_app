import 'package:flutter/material.dart';
import 'package:recipe_app/helpers/responsive/size_helper_extension.dart';
import 'package:recipe_app/presentation/home/widgets/my_sliver_app_bar.dart'
    show MySliverAppBar;
import 'package:recipe_app/presentation/home/widgets/search_filter.dart'
    show SearchFilter;
import 'package:recipe_app/presentation/home/widgets/recipe_list.dart'
    show RecipeList;
import 'package:recipe_app/presentation/home/widgets/tag_list.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      headerSliverBuilder: (context, builder) => [
        MySliverAppBar(child: SearchFilter()),
      ],
      body: ListView(
        children: [
          TagList(),
          RecipeList(),
          SizedBox(height: context.setHeight(50)),
        ],
      ),
    );
  }
}
