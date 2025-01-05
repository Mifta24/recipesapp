import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  final String username = 'John Doe';  // Contoh nama pengguna
  final String email = 'johndoe@example.com';  // Contoh email pengguna
  final String profileImage = 'https://www.example.com/profile.jpg';  // URL gambar profil

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        backgroundColor: Colors.green,
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              // Navigasi ke halaman pengaturan
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => SettingsPage()),
              // );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Foto Profil
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(60),
                child: Image.network(
                  profileImage,
                  width: 120,
                  height: 120,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 16),

            // Nama Pengguna
            Center(
              child: Text(
                username,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 8),

            // Email Pengguna
            Center(
              child: Text(
                email,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
              ),
            ),
            SizedBox(height: 24),

            // Menu Pilihan
            _buildMenuOption(
              context,
              icon: Icons.favorite,
              label: "Favorite Recipes",
              onTap: () {
                // Navigasi ke halaman resep favorit
              },
            ),
            _buildMenuOption(
              context,
              icon: Icons.edit,
              label: "Edit Profile",
              onTap: () {
                // Navigasi ke halaman edit profil
              },
            ),
            _buildMenuOption(
              context,
              icon: Icons.exit_to_app,
              label: "Logout",
              onTap: () {
                // Fitur logout
              },
            ),
          ],
        ),
      ),
    );
  }

  // Widget untuk membuat item menu
  Widget _buildMenuOption(BuildContext context, {required IconData icon, required String label, required Function onTap}) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Card(
        elevation: 5,
        margin: EdgeInsets.symmetric(vertical: 8),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Icon(icon, size: 28, color: Colors.green),
              SizedBox(width: 16),
              Text(
                label,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              Spacer(),
              Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }
}
