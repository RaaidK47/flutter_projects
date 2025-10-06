import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/screens/categories.dart';
import 'package:meals_app/screens/meals.dart';
import 'package:meals_app/widgets/main_drawer.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  final List<Meal> _favouriteMeals = [];

  void _showInfoMessage(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message))
    );
  }

  void _toggleMealFavouriteStatus(Meal meal) {
    final isExisting = _favouriteMeals.contains(meal);

    if (isExisting == true) {
      setState(() {
        _favouriteMeals.remove(meal);
        _showInfoMessage("Meal is No Longer a Favourite");
      });
      
    }
    else {
      setState(() {
        _favouriteMeals.add(meal);
        _showInfoMessage("Marked as a Favourite");
      });
    }
    // _favouriteMeals.forEach((meal) => print(meal.title));
  }

  void _setScreen(String identifier) {
    if (identifier == 'filters'){
      // We will Add Filters Screen later
    } else {
      // Else we go to Meals Screen
      // If we want to go to Meals screen, we have to close drawer first
      Navigator.of(context).pop(); //Closing Drawer
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget activePage = CategoriesScreen(onToggleFavourite: _toggleMealFavouriteStatus,);
    var activePageTitle = "Categories";

    if (_selectedPageIndex == 1) {
      // We are re-using MealsScreen for Favourites
      // Not Setting the Title
      activePage = MealsScreen(onToggleFavourite: _toggleMealFavouriteStatus, meals: _favouriteMeals);
      activePageTitle = "Your Favourites";
    }

    return Scaffold(
      appBar: AppBar(title: Text(activePageTitle)),
      drawer: MainDrawer(onSelectScreen: _setScreen,),
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
