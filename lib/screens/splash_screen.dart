import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:recipesapp/screens/home_screen.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Logo Animasi
          Image.asset(
            'assets/images/logo.png', // Ganti dengan logo Anda
            width: 120,
          ),
          const SizedBox(height: 20),
          // Teks Animasi
          Text(
            "Food Recipe App",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.orangeAccent,
            ),
          ),
        ],
      ),
      nextScreen: HomeScreen(), // Ganti dengan layar tujuan
      splashIconSize: 250,
      duration: 3000, // Durasi dalam milidetik
      splashTransition: SplashTransition.slideTransition,
      pageTransitionType: PageTransitionType.fade,
      backgroundColor: Colors.white, // Warna latar belakang
    );
  }
}
