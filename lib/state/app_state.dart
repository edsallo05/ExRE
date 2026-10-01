import 'package:flutter/material.dart';

import '../data/mock_resources.dart';
import '../models/resource.dart';

const String kCategoriaTodas = 'Todas';

/// Estado global de la app (usando solo ChangeNotifier del SDK de Flutter).
class AppState extends ChangeNotifier {
  final List<StudyResource> _resources = List.of(mockResources);

  final Set<String> _favoriteIds = {};
  final Set<String> _completedIds = {};

  String _selectedCategory = kCategoriaTodas;
  String _searchQuery = '';
  String? _openedResourceId;

  AppLifecycleState? _lastLifecycleState;
  final List<String> _lifecycleHistory = [];

  // ---------- Getters ----------
  List<StudyResource> get resources => List.unmodifiable(_resources);
  Set<String> get favoriteIds => Set.unmodifiable(_favoriteIds);
  Set<String> get completedIds => Set.unmodifiable(_completedIds);
  String get selectedCategory => _selectedCategory;
  String get searchQuery => _searchQuery;
  String? get openedResourceId => _openedResourceId;
  AppLifecycleState? get lastLifecycleState => _lastLifecycleState;
  List<String> get lifecycleHistory => List.unmodifiable(_lifecycleHistory);

  int get totalCount => _resources.length;
  int get favoriteCount => _favoriteIds.length;
  int get completedCount => _completedIds.length;
  int get pendingCount => totalCount - completedCount;

  double get completedPercent =>
      totalCount == 0 ? 0 : completedCount / totalCount;

  List<StudyResource> get favoriteResources =>
      _resources.where((r) => _favoriteIds.contains(r.id)).toList();

  List<StudyResource> get completedResources =>
      _resources.where((r) => _completedIds.contains(r.id)).toList();

  /// Recursos filtrados por categoría y búsqueda (para Catálogo).
  List<StudyResource> get filteredResources {
    return _resources.where((r) {
      final matchesCategory =
          _selectedCategory == kCategoriaTodas ||
          r.category == _selectedCategory;
      final query = _searchQuery.trim().toLowerCase();
      final matchesQuery =
          query.isEmpty ||
          r.title.toLowerCase().contains(query) ||
          r.category.toLowerCase().contains(query) ||
          r.author.toLowerCase().contains(query);
      return matchesCategory && matchesQuery;
    }).toList();
  }

  StudyResource? findById(String id) {
    for (final r in _resources) {
      if (r.id == id) return r;
    }
    return null;
  }

  /// Conteo de recursos completados por categoría (para Progreso).
  Map<String, int> get completedByCategory {
    final map = <String, int>{for (final c in studyCategories) c: 0};
    for (final r in completedResources) {
      map[r.category] = (map[r.category] ?? 0) + 1;
    }
    return map;
  }

  // ---------- Mutaciones ----------
  bool isFavorite(String id) => _favoriteIds.contains(id);
  bool isCompleted(String id) => _completedIds.contains(id);

  void toggleFavorite(String id) {
    if (!_favoriteIds.remove(id)) {
      _favoriteIds.add(id);
    }
    notifyListeners();
  }

  void toggleCompleted(String id) {
    if (!_completedIds.remove(id)) {
      _completedIds.add(id);
    }
    notifyListeners();
  }

  void setCategory(String category) {
    _selectedCategory = category;
    notifyListeners();
  }

  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  void setOpenedResource(String? id) {
    _openedResourceId = id;
    notifyListeners();
  }

  void recordLifecycleEvent(AppLifecycleState state) {
    _lastLifecycleState = state;
    _lifecycleHistory.insert(0, _lifecycleLabel(state));
    if (_lifecycleHistory.length > 6) {
      _lifecycleHistory.removeLast();
    }
    notifyListeners();
  }

  String _lifecycleLabel(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        return 'resumed';
      case AppLifecycleState.inactive:
        return 'inactive';
      case AppLifecycleState.paused:
        return 'paused';
      case AppLifecycleState.detached:
        return 'detached';
      case AppLifecycleState.hidden:
        return 'hidden';
    }
  }
}

/// InheritedNotifier propio para exponer AppState a todo el árbol
/// sin usar paquetes externos de manejo de estado.
class AppStateScope extends InheritedNotifier<AppState> {
  const AppStateScope({
    super.key,
    required AppState appState,
    required super.child,
  }) : super(notifier: appState);

  static AppState of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<AppStateScope>();
    assert(scope != null, 'No se encontró AppStateScope en el árbol');
    return scope!.notifier!;
  }
}
