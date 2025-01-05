import 'package:flutter/material.dart';
import 'package:recipesapp/models/recipe_model.dart';
import 'package:recipesapp/services/api_service.dart';
import 'package:recipesapp/screens/recipe_detail_screen.dart';

class RecipeListScreen extends StatefulWidget {
  @override
  _RecipeListScreenState createState() => _RecipeListScreenState();
}

class _RecipeListScreenState extends State<RecipeListScreen> {
  final ApiService _apiService = ApiService();
  final ScrollController _scrollController = ScrollController();

  List<Recipe> _recipes = [];
  bool _isLoading = false;
  bool _hasMore = true;
  int _currentOffset = 0;
  final int _recipesPerPage = 10;

  @override
  void initState() {
    super.initState();
    _fetchRecipes();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _fetchRecipes() async {
    if (_isLoading || !_hasMore) return;

    setState(() {
      _isLoading = true;
    });

    try {
      final newRecipes = await _apiService.fetchRecipeList(
        number: _recipesPerPage,
        offset: _currentOffset,
      );

      setState(() {
        _recipes.addAll(newRecipes);
        _currentOffset += _recipesPerPage;
        if (newRecipes.length < _recipesPerPage) {
          _hasMore = false; // Tidak ada data lagi untuk dimuat
        }
      });
    } catch (e) {
      // Tangani error sesuai kebutuhan
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load recipes: $e')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 200 &&
        !_isLoading) {
      _fetchRecipes();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Recipes"),
      ),
      body: _recipes.isEmpty && _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              controller: _scrollController,
              itemCount: _recipes.length + (_hasMore ? 1 : 0),
              itemBuilder: (context, index) {
                if (index < _recipes.length) {
                  final recipe = _recipes[index];
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
                      margin: const EdgeInsets.all(8.0),
                      child: ListTile(
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            recipe.image ?? 'https://via.placeholder.com/150',
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          ),
                        ),
                        title: Text(
                          recipe.title,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  );
                } else {
                  // Tampilkan indikator loading di bawah saat memuat lebih banyak data
                  return const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Center(child: CircularProgressIndicator()),
                  );
                }
              },
            ),
    );
  }
}
