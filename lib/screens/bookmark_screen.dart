import 'package:flutter/material.dart';


class BookmarkScreen extends StatelessWidget {
  final List<Map<String, String>> bookmarkedRecipes = [
    {
      'id': '1',
      'name': 'Spaghetti Carbonara',
      'image': 'https://www.example.com/spaghetti.jpg',
      'description':
          'A classic Italian pasta dish made with eggs, cheese, pancetta, and pepper.'
    },
    {
      'Id': '2',
      'name': 'Chicken Curry',
      'image': 'https://www.example.com/chicken_curry.jpg',
      'description':
          'A rich and spicy curry made with chicken, coconut milk, and Indian spices.'
    },
    // Tambahkan resep lainnya yang sudah di-bookmark
  ];

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
                "Bookmarked Recipes",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 20),

              // Dynamic list of bookmarked categories
              Expanded(
                child: bookmarkedRecipes.isEmpty
                    ? Center(
                        child: Text(
                          'No recipes bookmarked yet.',
                          style: TextStyle(fontSize: 18, color: Colors.grey),
                        ),
                      )
                    : ListView.builder(
                        itemCount: bookmarkedRecipes.length,
                        itemBuilder: (context, index) {
                          return _buildRecipeCard(
                              context, bookmarkedRecipes[index]);
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget untuk menampilkan kartu resep di daftar bookmark
  Widget _buildRecipeCard(BuildContext context, Map<String, String> recipe) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        contentPadding: EdgeInsets.all(10),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(
            recipe['image']!,
            width: 80,
            height: 80,
            fit: BoxFit.cover,
          ),
        ),
        title: Text(
          recipe['name']!,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          recipe['description']!,
          style: TextStyle(fontSize: 14, color: Colors.grey),
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
        ),
        trailing: IconButton(
          icon: Icon(Icons.delete, color: Colors.red),
          onPressed: () {
            // Hapus resep dari bookmark
            // Implementasikan logika untuk menghapus resep dari daftar bookmark
          },
        ),
        onTap: () {
          // Navigasi ke halaman detail resep
          // Navigator.push(
          //   context,
          //   // MaterialPageRoute(
          //   //  // builder: (context) => RecipeDetailPage(recipeId: recipe['id']!),
          //   // ),
          // );
        },
      ),
    );
  }
}
