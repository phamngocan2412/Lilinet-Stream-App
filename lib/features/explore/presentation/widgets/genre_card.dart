// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import '../../domain/entities/genre.dart';

class GenreCard extends StatelessWidget {
  final Genre genre;
  final VoidCallback onTap;

  const GenreCard({super.key, required this.genre, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final gradients = _getGenreGradient(genre.name);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: gradients,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: gradients.first.withOpacity(0.3),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Stack(
          children: [
            Positioned(
              right: -20,
              bottom: -20,
              child: Icon(
                _getGenreIcon(genre.name),
                size: 100,
                color: Colors.white.withOpacity(0.2),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    _getGenreIcon(genre.name),
                    color: Colors.white,
                    size: 32,
                  ),
                  Text(
                    genre.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Color> _getGenreGradient(String name) {
    switch (name.toLowerCase()) {
      case 'action':
        return [Colors.red.shade700, Colors.orange.shade600];
      case 'comedy':
        return [Colors.amber.shade600, Colors.yellow.shade500];
      case 'drama':
        return [Colors.purple.shade700, Colors.pink.shade500];
      case 'horror':
        return [Colors.grey.shade900, Colors.red.shade900];
      case 'romance':
        return [Colors.pink.shade400, Colors.red.shade300];
      case 'sci-fi':
      case 'science fiction':
        return [Colors.cyan.shade600, Colors.blue.shade700];
      case 'thriller':
        return [Colors.indigo.shade800, Colors.purple.shade900];
      case 'animation':
        return [Colors.green.shade400, Colors.teal.shade500];
      case 'adventure':
        return [Colors.orange.shade600, Colors.deepOrange.shade500];
      case 'fantasy':
        return [Colors.deepPurple.shade500, Colors.indigo.shade600];
      case 'crime':
        return [Colors.blueGrey.shade800, Colors.grey.shade700];
      case 'mystery':
        return [Colors.indigo.shade900, Colors.blueGrey.shade800];
      default:
        return [Colors.blue.shade600, Colors.purple.shade600];
    }
  }

  IconData _getGenreIcon(String name) {
    switch (name.toLowerCase()) {
      case 'action':
        return Icons.local_fire_department;
      case 'comedy':
        return Icons.sentiment_very_satisfied;
      case 'drama':
        return Icons.theater_comedy;
      case 'horror':
        return Icons.nights_stay;
      case 'romance':
        return Icons.favorite;
      case 'sci-fi':
      case 'science fiction':
        return Icons.rocket_launch;
      case 'thriller':
        return Icons.flash_on;
      case 'animation':
        return Icons.animation;
      case 'adventure':
        return Icons.explore;
      case 'fantasy':
        return Icons.auto_awesome;
      case 'crime':
        return Icons.gavel;
      case 'mystery':
        return Icons.search;
      case 'documentary':
        return Icons.movie_filter;
      case 'family':
        return Icons.family_restroom;
      case 'history':
        return Icons.history_edu;
      case 'music':
        return Icons.music_note;
      case 'war':
        return Icons.shield;
      case 'western':
        return Icons.landscape;
      default:
        return Icons.movie;
    }
  }
}
