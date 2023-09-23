import 'package:flutter/material.dart';
//import 'package:meals/data/dummy_data.dart';
import 'package:meals/providers/favourites_provider.dart';
import 'package:meals/screens/categories.dart';
import 'package:meals/screens/filters.dart';
import 'package:meals/screens/meals.dart';
//import 'package:meals/models/meal.dart';
import 'package:meals/providers/meals_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/widgets/main-drawer.dart';
import 'package:meals/providers/filters_provider.dart';

const kInitialFilters = {
  Filter.glutanFree: false,
  Filter.lactoseFree: false,
  Filter.vegitarian: false,
  Filter.vegan: false,
};

class TabsScreen extends ConsumerStatefulWidget {
  // to reach ou to providers.
  const TabsScreen({super.key});
  @override
  ConsumerState<TabsScreen> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  //Map<Filter, bool> _selectedFilters = kInitialFilters;
  int _selectedPageIndex = 0;
  //final List<Meal> _favouriteMeals = [];

  //void _showInfoMessage(String message) {
  //ScaffoldMessenger.of(context).clearSnackBars();
  //ScaffoldMessenger.of(context)
  //  .showSnackBar(SnackBar(content: Text(message)));
  //}

  // void _toggleMealFavouriteStatus(Meal meal) {
  // tab screen doesn't have direct access to meal details screen
  //   final isExisiting = _favouriteMeals.contains(meal);
  //   if (isExisiting) {
  //     setState(() {
  // use set state to automatically update the ui after remove.
  //       _favouriteMeals.remove(meal);
  //     });
  //     _showInfoMessage('Meal is no longer favourite');
  //   } else {
  //     _favouriteMeals.add(meal);
  //     _showInfoMessage('Marke as favourite!!');
  //   }
  // }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void _setScreen(String identifier) async {
    //for drawer screen.
    Navigator.of(context).pop();
    if (identifier == 'filters') {
      //Navigator.of(context).pop(); // to pop the drawer before moving to filter screen.
      //final result =
      await Navigator.of(context).push<Map<Filter, bool>>(
        MaterialPageRoute(
          builder: (ctx) => const FiltersScreen(
              //currentFilters: _selectedFilters,
              ),
        ),
      );
      //setState(() {
      //_selectedFilters = result ??
      //    kInitialFilters; // double? allows to set up fall back value when result is null.
      //});
    } //else {
    //Navigator.of(context).pop(); // coz meals screen is the main screen that apears first. so we close the drawer.
    //}
  }

  @override // it only has access to categories screen and meals screen.
  Widget build(BuildContext context) {
    final meals =
        ref.watch(mealsProvider); // listener to re-execute build method.
    final activeFilters = ref.watch(filterProvider);
    final availabeMeals = meals.where((meal) {
      //here in place of dummyMeals we will use provider which is meals .
      if (activeFilters[Filter.glutanFree]! && !meal.isGlutenFree) {
        //if (_selectedFilters[Filter.glutanFree]! && !meal.isGlutenFree) {
        // filter is gluten free but meal is not.
        return false;
      }
      if (activeFilters[Filter.lactoseFree]! && !meal.isLactoseFree) {
        //if (_selectedFilters[Filter.lactoseFree]! && !meal.isLactoseFree) {
        // filter is gluten free but meal is not.
        return false;
      }
      if (activeFilters[Filter.vegitarian]! && !meal.isVegetarian) {
        //if (_selectedFilters[Filter.vegitarian]! && !meal.isVegetarian) {
        // filter is gluten free but meal is not.
        return false;
      }
      if (activeFilters[Filter.vegan]! && !meal.isVegan) {
        //if (_selectedFilters[Filter.vegan]! && !meal.isVegan) {
        // filter is gluten free but meal is not.
        return false;
      }
      return true;
    }).toList();

    Widget activePage = CategoriesScreen(
      // both the screens reach meal details screen.
      //categories screen is also using meals screen so its necessorty to do the needful there.
      //onToggleFavourites: _toggleMealFavouriteStatus,
      availabeMeals: availabeMeals,
    );
    var activePageTitle = 'Categories';

    if (_selectedPageIndex == 1) {
      final favouriteMeals = ref.watch(favouriteMealsProvider);
      activePage = MealsScreen(
          meals:
              favouriteMeals // _favouriteMeals, // favourite meals will be added to the screen.
          //onToggleFavourites:
          //_toggleMealFavouriteStatus, // and here will set to status function.
          );
      activePageTitle = 'Your Favourites';
    }
    return Scaffold(
      // here we'll add side drawer to be present on both the tabs.
      appBar: AppBar(
        title: Text(activePageTitle),
      ),

      drawer: MainDrawer(
        onSelectScreen: _setScreen,
      ),

      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        //to add tab bar at the bottom.
        onTap: _selectPage,
        currentIndex: _selectedPageIndex,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.set_meal), label: 'Categories'),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Favourite'),
        ],
      ),
    );
  }
}
