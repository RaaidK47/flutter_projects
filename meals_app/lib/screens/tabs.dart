import 'package:flutter/material.dart';
import 'package:meals_app/data/dummy_data.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/screens/categories.dart';
import 'package:meals_app/screens/filters.dart';
import 'package:meals_app/screens/meals.dart';
import 'package:meals_app/widgets/main_drawer.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _TabsScreenState();
  }
}

const kInitialFilters = {
  Filter.glutenFree: false,
  Filter.lactoseFree: false,
  Filter.vegetarian: false,
  Filter.vegan: false,
};

class _TabsScreenState extends State<TabsScreen> {
  int _selectedPageIndex = 0;

  Map<Filter, bool> _selectedFilters = kInitialFilters;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  final List<Meal> _favouriteMeals = [];

  void _showInfoMessage(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  void _toggleMealFavouriteStatus(Meal meal) {
    final isExisting = _favouriteMeals.contains(meal);

    if (isExisting == true) {
      setState(() {
        _favouriteMeals.remove(meal);
        _showInfoMessage("Meal is No Longer a Favourite");
      });
    } else {
      setState(() {
        _favouriteMeals.add(meal);
        _showInfoMessage("Marked as a Favourite");
      });
    }
    // _favouriteMeals.forEach((meal) => print(meal.title));
  }

  Future<void> _setScreen(String identifier) async {
    Navigator.of(context).pop(); //Closing Drawer
    if (identifier == 'filters') {
      // We will Add Filters Screen later
      // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx) => FiltersScreen()));
      final results = await Navigator.of(context).push<Map<Filter, bool>>(
        MaterialPageRoute(builder: (ctx) => FiltersScreen(currentFilters: _selectedFilters,)),
      );
      setState(() {
        _selectedFilters = results ?? kInitialFilters;
      });

      // print(results);
    }
  }

  @override
  Widget build(BuildContext context) {
    final availableMeals = dummyMeals.where((meal) {
      if (_selectedFilters[Filter.glutenFree]! && !meal.isGlutenFree) {
        return false;
      }
      if (_selectedFilters[Filter.lactoseFree]! && !meal.isLactoseFree) {
        return false;
      }
      if (_selectedFilters[Filter.vegetarian]! && !meal.isVegetarian) {
        return false;
      }
      if (_selectedFilters[Filter.vegan]! && !meal.isVegan) {
        return false;
      }
      return true;
    }).toList();

    Widget activePage = CategoriesScreen(
      onToggleFavourite: _toggleMealFavouriteStatus,
      availableMeals: availableMeals,
    );
    var activePageTitle = "Categories";

    if (_selectedPageIndex == 1) {
      // We are re-using MealsScreen for Favourites
      // Not Setting the Title
      activePage = MealsScreen(
        onToggleFavourite: _toggleMealFavouriteStatus,
        meals: _favouriteMeals,
      );
      activePageTitle = "Your Favourites";
    }

    return Scaffold(
      appBar: AppBar(title: Text(activePageTitle)),
      drawer: MainDrawer(onSelectScreen: _setScreen),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        // index > Index of Tab in BottomNavigationBar
        onTap: _selectPage,
        currentIndex: _selectedPageIndex, //To Highlight the Selected Tab
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.set_meal),
            label: "Categories",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: "Favourites"),
        ],
      ),
    );
  }
}
