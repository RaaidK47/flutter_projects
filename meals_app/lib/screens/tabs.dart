import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/screens/categories.dart';
import 'package:meals_app/screens/meals.dart';

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
