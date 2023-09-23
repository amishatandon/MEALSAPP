import 'package:flutter/material.dart';
//import 'package:meals/screens/tabs.dart';
//import 'package:meals/widgets/main-drawer.dart';
import 'package:meals/providers/filters_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
//enum Filter {
//glutanFree,
//lactoseFree,
//vegitarian,
//vegan,
//}

class FiltersScreen extends ConsumerStatefulWidget {
  const FiltersScreen({
    super.key,
    //required this.currentFilters,
  });
  //final Map<Filter, bool> currentFilters;

  @override
  ConsumerState<FiltersScreen> createState() {
    return _FiltersScreenState();
  }
}

class _FiltersScreenState extends ConsumerState<FiltersScreen> {
  var _glutenFreeFilterSet = false;
  var _lactoseFreeFilterSet = false;
  var _vegitarianFreeFilterSet = false;
  var _veganFreeFilterSet = false;
  @override
  void initState() {
    super.initState();
    final activeFilters = ref.read(filterProvider);
    _glutenFreeFilterSet = activeFilters[
        Filter.glutanFree]!; //widget.currentFilters[Filter.glutanFree]!;
    _lactoseFreeFilterSet = activeFilters[
        Filter.lactoseFree]!; //widget.currentFilters[Filter.lactoseFree]!;
    _vegitarianFreeFilterSet = activeFilters[
        Filter.vegitarian]!; //widget.currentFilters[Filter.vegitarian]!;
    _veganFreeFilterSet =
        activeFilters[Filter.vegan]!; //widget.currentFilters[Filter.vegan]!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Filters'),
      ),
      //drawer: MainDrawer(onSelectScreen: (identifier) {
      //Navigator.of(context).pop();
      //if (identifier == 'meals') {
      //Navigator.of(context).pushReplacement(
      //instead of push , pushReplacement, this makes sure screen is not pushed as a new screen but instead replaced.
      //MaterialPageRoute(
      //builder: (ctx) => const TabsScreen(),
      //),
      //);
      // }
      //}),
      body: WillPopScope(
        onWillPop: () async {
          // return value will be turn into future
          //wants a function that returns such a future, values which are not yet.
          ref.read(filterProvider.notifier).setFilters({
            Filter.glutanFree: _glutenFreeFilterSet,
            Filter.lactoseFree: _lactoseFreeFilterSet,
            Filter.vegitarian: _vegitarianFreeFilterSet,
            Filter.vegan: _veganFreeFilterSet,
          });
          // Navigator.of(context).pop({
          // Filter.glutanFree: _glutenFreeFilterSet,
          //Filter.lactoseFree: _lactoseFreeFilterSet,
          //Filter.vegitarian: _vegitarianFreeFilterSet,
          //Filter.vegan: _veganFreeFilterSet,
          // } ); //we will return tha data to the tabs screen selected from here.
          return true; //return false; // return true or false to know weather we have to navigate or not.
        },
        child: Column(
          children: [
            SwitchListTile(
              value: _glutenFreeFilterSet,
              onChanged: (isChecked) {
                setState(() {
                  _glutenFreeFilterSet = isChecked;
                });
              },
              title: Text(
                'Gluten-free',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
              subtitle: Text(
                'only include gluten-free meals',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
              activeColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: const EdgeInsets.only(
                left: 34,
                right: 22,
              ),
            ), // presents one single row in the list.
            SwitchListTile(
              value: _lactoseFreeFilterSet,
              onChanged: (isChecked) {
                setState(() {
                  _lactoseFreeFilterSet = isChecked;
                });
              },
              title: Text(
                'Lactose-free',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
              subtitle: Text(
                'only include lactose-free meals',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
              activeColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: const EdgeInsets.only(
                left: 34,
                right: 22,
              ),
            ),
            SwitchListTile(
              value: _vegitarianFreeFilterSet,
              onChanged: (isChecked) {
                setState(() {
                  _vegitarianFreeFilterSet = isChecked;
                });
              },
              title: Text(
                'Vegitarian-free',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
              subtitle: Text(
                'only include vegitarian-free meals',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
              activeColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: const EdgeInsets.only(
                left: 34,
                right: 22,
              ),
            ),
            SwitchListTile(
              value: _veganFreeFilterSet,
              onChanged: (isChecked) {
                setState(() {
                  _veganFreeFilterSet = isChecked;
                });
              },
              title: Text(
                'Vegan-free',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
              subtitle: Text(
                'only include vegan-free meals',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
              activeColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: const EdgeInsets.only(
                left: 34,
                right: 22,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
