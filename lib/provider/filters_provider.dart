import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meal_app/data/dummydata.dart';

enum Filter {
  glutenfree,
  lactosefree,
  vegetarian,
  vegan,
}

class FilterNotifier extends StateNotifier<Map<Filter, bool>> {
  FilterNotifier()
      : super({
          Filter.glutenfree: false,
          Filter.lactosefree: false,
          Filter.vegetarian: false,
          Filter.vegan: false,
        });

  void setfilters(Map<Filter, bool> chosenfilter) {
    state = chosenfilter;
  }

  void setfilter(Filter filter, bool isactive) {
    state = {...state, filter: isactive};
  }
}

final filtersprovider =
    StateNotifierProvider<FilterNotifier, Map<Filter, bool>>((ref) {
  return FilterNotifier();
});

final filtermealprovider = Provider((ref) {
  final activefilter = ref.watch(filtersprovider);
  return dummyMeals.where((meal) {
    if (activefilter[Filter.glutenfree]! && !meal.isGlutenFree) {
      return false;
    }
    if (activefilter[Filter.lactosefree]! && !meal.isLactoseFree) {
      return false;
    }
    if (activefilter[Filter.vegetarian]! && !meal.isVegetarian) {
      return false;
    }
    if (activefilter[Filter.vegan]! && !meal.isVegan) {
      return false;
    }
    return true;
  }).toList();
});
