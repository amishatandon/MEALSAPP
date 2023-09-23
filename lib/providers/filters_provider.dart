import 'package:flutter_riverpod/flutter_riverpod.dart';

enum Filter {
  //from filters.dart.
  glutanFree,
  lactoseFree,
  vegitarian,
  vegan,
}

class FiltersNotifier extends StateNotifier<Map<Filter, bool>> {
  FiltersNotifier()
      : super({
          Filter.glutanFree: false,
          Filter.lactoseFree: false,
          Filter.vegitarian: false,
          Filter.vegan: false,
        });
  void setFilters(Map<Filter, bool> chosenFilters) {
    state = chosenFilters;
  }

  void setFilter(Filter filter, bool isActive) {
    //state[filter] = isActive; not allowed coz mutating the state.
    state = {
      ...state,
      filter: isActive,
    };
  }
}

final filterProvider =
    StateNotifierProvider<FiltersNotifier, Map<Filter, bool>>(
  (ref) => FiltersNotifier(),
);
