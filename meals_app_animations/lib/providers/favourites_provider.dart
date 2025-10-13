import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:meals_app/models/meal.dart';

class FavouriteMealsNotifier extends StateNotifier<List<Meal>> {
  // Initializing with Empty List
  FavouriteMealsNotifier() : super([]);

  // We will add methods to edit data
  bool toggleMealFavouriteStatus(Meal meal) {
    // state = data passed to this class as list
    final mealIsFavourite = state.contains(meal);

    if (mealIsFavourite) {
      // Removing the meal from favourites list
      state = state.where((m) => m.id != meal.id).toList();
      return false;
    } else {
      // Adding the meal to favourites list
      state = [...state, meal];
      return true;
    }
  }
}

// StateNotifierProvider() for Dynamic data
final favouriteMealsProvider =
    StateNotifierProvider<FavouriteMealsNotifier, List<Meal>>((ref) {
      return FavouriteMealsNotifier();
    });
