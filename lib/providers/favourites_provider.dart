import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/models/meal.dart';

class FavouriteMealsNotifier extends StateNotifier<List<Meal>> {
  FavouriteMealsNotifier() : super([]);

  bool toggleMealFavouriteStatus(Meal meal) {
    final mealIsFavourite = state.contains(meal);
    if (mealIsFavourite) {
      state = state
          .where((m) =>
              m.id != meal.id) //with where we filter a list and get a new list.
          .toList();
      return false;
    } else {
      state = [...state, meal]; //add all the existing meals and new meal.
      return true;
    }
  }
}

final favouriteMealsProvider =
    StateNotifierProvider<FavouriteMealsNotifier, List<Meal>>((ref) {
  return FavouriteMealsNotifier(); // returns instance of notifier class.
});
