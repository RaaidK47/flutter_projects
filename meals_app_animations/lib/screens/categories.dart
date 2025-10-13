import 'package:flutter/material.dart';
import 'package:meals_app/data/dummy_data.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/screens/meals.dart';
import 'package:meals_app/widgets/category_grid_item.dart';
import 'package:meals_app/models/category.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key, required this.availableMeals});

  final List<Meal> availableMeals;

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
      lowerBound: 0,
      upperBound: 1,
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _selectCategory(BuildContext context, Category category) {
    final filteredMeals = widget.availableMeals
        .where((meal) => meal.categories.contains(category.id))
        .toList();

    // Context is not globally available in Stateless Widget
    // [Similar] Navigator.push(context, route);
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) =>
            MealsScreen(title: category.title, meals: filteredMeals),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: AnimatedBuilder(
        animation: _animationController,
        child: GridView(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // Two Columns in Grid
            childAspectRatio: 3 / 2, //   Aspect Ration
            crossAxisSpacing: 20, // Horizontal Spacing
            mainAxisSpacing: 20, // Vertical Spacing
          ),
          children: [
            for (final category in availableCategories)
              CategoryGridItem(
                category: category,
                onSelectCategory: () {
                  _selectCategory(context, category);
                },
              ),
          ],
        ),

        // Sliding Up
        // builder: (context, child) =>  Padding(padding : EdgeInsets.only(top: 100 - _animationController.value * 100), child: child),

        // Using SlideTransition
        // builder: (context, child) => SlideTransition(
        //   position: _animationController.drive(
        //     // Tween() = Between
        //     Tween(begin: const Offset(0, 0.3), end: const Offset(0, 0)),
        //   ),
        //   child: child,
        // ),

        builder: (context, child) => SlideTransition(
          position: Tween(begin: const Offset(0, 0.3), end: const Offset(0, 0))
              .animate(
                CurvedAnimation(
                  parent: _animationController,
                  curve: Curves.easeInOut,
                ),
              ),
        child: child,),
      ),
    );
  }
}
