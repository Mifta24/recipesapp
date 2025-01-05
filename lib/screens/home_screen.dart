import 'package:flutter/material.dart';
import 'package:recipesapp/models/recipe_model.dart';
import 'package:recipesapp/screens/bookmark_screen.dart';
import 'package:recipesapp/screens/profile_screen.dart';
import 'package:recipesapp/screens/recipe_detail_screen.dart';
import 'package:recipesapp/screens/recipe_list_screen.dart';
import 'package:recipesapp/services/api_service.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ApiService _apiService = ApiService();
  late Future<List<Recipe>> recipes;
  final TextEditingController _searchController = TextEditingController();
  int _selectedIndex = 0;
  String? _selectedCategory;

  @override
  void initState() {
    super.initState();
    _loadInitialRecipes();
  }

  void _loadInitialRecipes() {
    setState(() {
      recipes = _apiService.fetchRandomRecipes(number: 10);
    });
  }

  void _searchRecipes(String query) {
    if (query.isEmpty) {
      _loadInitialRecipes();
    } else {
      setState(() {
        recipes = _apiService.fetchRecipes(query, number: 10);
      });
    }
  }

  void _filterByCategory(String category) {
    setState(() {
      _selectedCategory = category;
      recipes = _apiService.fetchRecipes(category, number: 10);
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _selectedIndex == 0
          ? SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeader(),
                    const SizedBox(height: 20),
                    _buildSearchBar(),
                    const SizedBox(height: 20),
                    _buildCategories(),
                    const SizedBox(height: 20),
                    _buildRecipeList(),
                  ],
                ),
              ),
            )
          : _buildPageByIndex(),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              "Hello, Anne",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 5),
            Text(
              "What would you like to cook today?",
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ],
        ),
        const CircleAvatar(
          radius: 20,
          backgroundImage: AssetImage('assets/images/avatar.jpg'),
        ),
      ],
    );
  }

  Widget _buildSearchBar() {
    return TextField(
      controller: _searchController,
      onChanged: _searchRecipes,
      decoration: InputDecoration(
        hintText: "Search any recipes",
        prefixIcon: const Icon(Icons.search),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  Widget _buildCategories() {
    return Row(
      children: [
        _buildCategoryChip("Vegetarian"),
        const SizedBox(width: 10),
        _buildCategoryChip("Gluten Free"),
      ],
    );
  }

  Widget _buildCategoryChip(String category) {
    return GestureDetector(
      onTap: () => _filterByCategory(category),
      child: Chip(
        label: Text(category),
        backgroundColor:
            _selectedCategory == category ? Colors.green : Colors.grey.shade300,
        labelStyle: TextStyle(
          color: _selectedCategory == category ? Colors.white : Colors.black,
        ),
      ),
    );
  }

  Widget _buildRecipeList() {
    return Expanded(
      child: FutureBuilder<List<Recipe>>(
        future: recipes,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text("No recipes found."),
            );
          }

          final recipeList = snapshot.data!;
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            itemCount: recipeList.length,
            itemBuilder: (context, index) {
              final recipe = recipeList[index];
              return GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        RecipeDetailScreen(recipeId: recipe.id),
                  ),
                ),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(12),
                          topRight: Radius.circular(12),
                        ),
                        child: Image.network(
                          recipe.image ?? 'https://via.placeholder.com/150',
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: 120,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          recipe.title,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildPageByIndex() {
    switch (_selectedIndex) {
      case 1:
        return RecipeListScreen();
      case 2:
        return BookmarkScreen();
      case 3:
        return ProfileScreen();
      default:
        return const Center(child: Text("Page not found"));
    }
  }

  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: _selectedIndex,
      onTap: _onItemTapped,
      selectedItemColor: Colors.green[800],
      unselectedItemColor: Colors.black54,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Recipes'),
        BottomNavigationBarItem(icon: Icon(Icons.bookmark), label: 'Bookmark'),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_circle),
          label: 'Profile',
        ),
      ],
    );
  }
}
