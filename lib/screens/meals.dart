import 'package:flutter/material.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/screens/meal_details.dart';
import 'package:meals/widgets/meal_item.dart';

class MealsScreen extends StatelessWidget {
  const MealsScreen({
    super.key,
    required this.meals,
    this.title,
    // required this.onToggleFavourites,
  });

  final String? title;
  final List<Meal> meals;
  //final void Function(Meal meal)
  //onToggleFavourites; // we create this other function and forward it to meals detail screen.
  //so after this inside tabs we have to pass such argument to meals screen.

  void selectMeal(Meal meal, BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => MealDetailsScreen(
          meal: meal,
          //onToggleFavourite: onToggleFavourites,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget content = ListView.builder(
        itemCount: meals.length,
        itemBuilder: (ctx, index) => MealItem(
              meal: meals[index],
              onSelectMeal: selectMeal,
            ));
    if (meals.isEmpty) {
      content = Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'uh no..nothing here!!',
              style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              'try slelecting  a different category!!',
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            ),
          ],
        ),
      );
    }

    if (title == null) {
      return content;
    }
    return Scaffold(
        appBar: AppBar(
          title: Text(title!),
        ),
        body: content);
  }
}
