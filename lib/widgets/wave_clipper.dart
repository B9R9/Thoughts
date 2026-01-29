import 'package:flutter/material.dart';

class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();

    // Départ en haut à gauche
    path.lineTo(0, 10);

    // Première courbe (gauche)
    path.quadraticBezierTo(size.width * 0.25, 0, size.width * 0.5, 15);

    // Deuxième courbe (droite)
    path.quadraticBezierTo(size.width * 0.75, 30, size.width, 15);

    // Compléter le rectangle
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
