import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

enum ResourceType { video, lectura, practica, documento }

extension ResourceTypeX on ResourceType {
  String get label {
    switch (this) {
      case ResourceType.video:
        return 'Video';
      case ResourceType.lectura:
        return 'Lectura';
      case ResourceType.practica:
        return 'Práctica';
      case ResourceType.documento:
        return 'Documento';
    }
  }

  IconData get icon {
    switch (this) {
      case ResourceType.video:
        return Icons.play_circle_fill;
      case ResourceType.lectura:
        return Icons.menu_book_rounded;
      case ResourceType.practica:
        return Icons.terminal_rounded;
      case ResourceType.documento:
        return Icons.description_rounded;
    }
  }
}

class StudyResource {
  final String id;
  final String title;
  final String category;
  final String author;
  final int durationMinutes;
  final String level;
  final String description;
  final ResourceType type;
  final String content;

  const StudyResource({
    required this.id,
    required this.title,
    required this.category,
    required this.author,
    required this.durationMinutes,
    required this.level,
    required this.description,
    required this.type,
    required this.content,
  });

  Color get color => AppColors.forCategory(category);

  String get levelLabel {
    switch (level) {
      case 'basico':
        return 'Básico';
      case 'intermedio':
        return 'Intermedio';
      case 'avanzado':
        return 'Avanzado';
      default:
        return level;
    }
  }
}
