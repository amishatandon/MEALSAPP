import 'package:flutter/material.dart';
import 'package:meals/data/dummy_data.dart';
import 'package:meals/screens/meals.dart';
import 'package:meals/widgets/category_grid_item.dart';
import 'package:meals/models/category.dart';

import '../models/meal.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({
    super.key,
    //required this.onToggleFavourites,
    required this.availabeMeals,
  });

  //final void Function(Meal meal)
  //onToggleFavourites; //we add this property here, too.
  final List<Meal> availabeMeals;

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController
      _animationController; // late tell that _animationController will have value as soon as its used the first time noy yet when the class is created.

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 300,
      ),
      lowerBound: 0,
      upperBound: 1,
    ); //vsync ensure the animation execute for every frame.
    _animationController.forward(); //start the animation also can use repeat.
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _selesctCategory(BuildContext context, Category category) {
    final filteredMeals = widget.availabeMeals
        .where((meal) => meal.categories.contains(category.id))
        .toList();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (ctx) => MealsScreen(
          meals: filteredMeals,
          title: category.title,
          //onToggleFavourites: onToggleFavourites, //pass the value here.
        ),
      ),
    ); //route which will be a wiget will be pushed ob the current screen.
    //same as writing Navigator.of(context).push(route)
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      child: GridView(
        // this will not be rebuild again as its only a part of animation controller.
        padding: const EdgeInsets.all(25),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2, //impact the sizing of grid view items.
          crossAxisSpacing: 20, //for spacing b/w the columns
          mainAxisSpacing: 20,
        ), //cross axis count 2 means horizontally 2 columns.
        children: [
          for (final category
              in availableCategories) // for every available category in the model.
            CategoryGridItem(
              category: category,
              onSelectCategory: () {
                _selesctCategory(context, category);
              },
            )
        ],
      ),
      //builder: (context, child) => Padding(
      //padding: EdgeInsets.only(
      //top: 100 - _animationController.value * 100,
      //),
      //child: child,
      //),
      builder: (context, child) => SlideTransition(
        position: Tween(
          begin: const Offset(0, 0.3),
          end: const Offset(0, 0),
        ).animate(CurvedAnimation(
            parent: _animationController, curve: Curves.easeInOut)),
        child: child,
      ),
    );
  }
}
