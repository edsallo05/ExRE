import 'package:flutter/material.dart';

import '../state/app_state.dart';
import '../widgets/empty_state.dart';
import '../widgets/resource_list_card.dart';
import 'detail_screen.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = AppStateScope.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Favoritos')),
      body: AnimatedBuilder(
        animation: appState,
        builder: (context, _) {
          final favorites = appState.favoriteResources;
          if (favorites.isEmpty) {
            return const EmptyState(
              icon: Icons.favorite_border,
              title: 'Aún no tienes favoritos',
              message: 'Marca recursos con el corazón para verlos aquí.',
            );
          }
          return SafeArea(
            child: ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: favorites.length,
              separatorBuilder: (_, _) => const SizedBox(height: 10),
              itemBuilder: (context, index) {
                final resource = favorites[index];
                return Dismissible(
                  key: ValueKey(resource.id),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 20),
                    decoration: BoxDecoration(
                      color: Colors.red.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Icon(Icons.delete, color: Colors.redAccent),
                  ),
                  onDismissed: (_) => appState.toggleFavorite(resource.id),
                  child: ResourceListCard(
                    resource: resource,
                    onTap: () => _openDetail(context, resource.id),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }

  void _openDetail(BuildContext context, String id) {
    final appState = AppStateScope.of(context);
    appState.setOpenedResource(id);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const DetailScreen()),
    );
  }
}
