import 'package:flutter/material.dart';
import 'package:recipesapp/models/recipe_list_model.dart';
import 'package:recipesapp/screens/recipe_detail_screen.dart';
import 'package:recipesapp/services/api_service.dart';

class RecipeListScreen extends StatefulWidget {
  @override
  _RecipeListScreenState createState() => _RecipeListScreenState();
}

class _RecipeListScreenState extends State<RecipeListScreen> {
  final ApiService _apiService = ApiService();

  // Mendeklarasikan Future yang akan memuat data
  late Future<List<RecipeList>> _recipeList;

  @override
  void initState() {
    super.initState();
    // Memanggil API untuk mendapatkan data resep
    _recipeList = _apiService.fetchRecipeList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "All Recipes",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 20),

              // Menggunakan FutureBuilder untuk menangani status data dari API
              Expanded(
                child: FutureBuilder<List<RecipeList>>(
                  future: _recipeList, // Future untuk memuat data resep
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      // Menampilkan CircularProgressIndicator saat loading
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      // Menampilkan pesan error jika ada masalah
                      return Center(child: Text("Error: ${snapshot.error}"));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      // Menampilkan pesan jika data kosong
                      return Center(child: Text("No Recipes Found"));
                    } else {
                      // Menampilkan daftar resep jika data tersedia
                      final recipes = snapshot.data!;
                      return ListView.builder(
                        itemCount: recipes.length,
                        itemBuilder: (context, index) {
                          final recipe = recipes[index];
                          return ListTile(
                            title: Text(recipe.title),
                            leading: Image.network(
                              recipe.image ?? 'https://via.placeholder.com/150',
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      RecipeDetailScreen(recipeId: recipe.id),
                                ),
                              );
                            },
                          );
                        },
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
