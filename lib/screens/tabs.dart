import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meal_app/provider/favorite_provider.dart';
import 'package:meal_app/screens/categories.dart';
import 'package:meal_app/screens/filters.dart';
import 'package:meal_app/screens/meals.dart';
import 'package:meal_app/widgets/main_drawer.dart';
import 'package:meal_app/provider/filters_provider.dart';

const kinitialfilters = {
  Filter.glutenfree: false,
  Filter.lactosefree: false,
  Filter.vegetarian: false,
  Filter.vegan: false,
};

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});
  @override
  ConsumerState<TabsScreen> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  int _selectedpageindex = 0;

  void _selectscreen(String identifier) async {
    Navigator.of(context).pop();
    if (identifier == 'Filters') {
      await Navigator.of(context).push<Map<Filter, bool>>(
        MaterialPageRoute(builder: (ctx) => const FilterScreen()),
      );
    }
  }

  void _selectedpage(int index) {
    setState(() {
      _selectedpageindex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final availablemeals = ref.watch(filtermealprovider);

    Widget activescreen = CategoriesScreen(
      availablemeal: availablemeals,
    );
    var activepagetitle = 'Categories';

    if (_selectedpageindex == 1) {
      final favoritemeal = ref.watch(favoritemealprovider);
      activescreen = MealsScreen(
        meal: favoritemeal,
      );
      activepagetitle = 'Your Favorites';
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(activepagetitle),
      ),
      drawer: MainDrawer(onselectscreen: _selectscreen),
      body: activescreen,
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          _selectedpage(index);
        },
        currentIndex: _selectedpageindex,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.set_meal), label: 'CATEGORIES'),
          BottomNavigationBarItem(
              icon: Icon(Icons.star), label: 'YOUR FAVORITES'),
        ],
      ),
    );
  }
}
