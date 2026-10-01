import 'package:flutter/material.dart';

import '../state/app_state.dart';
import '../widgets/resource_grid_card.dart';
import 'detail_screen.dart';

class GalleryScreen extends StatelessWidget {
  const GalleryScreen({super.key});

  void _openDetail(BuildContext context, String id) {
    final appState = AppStateScope.of(context);
    appState.setOpenedResource(id);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const DetailScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final appState = AppStateScope.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Galería')),
      body: AnimatedBuilder(
        animation: appState,
        builder: (context, _) {
          final resources = appState.resources;
          return SafeArea(
            child: GridView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: resources.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 0.78,
              ),
              itemBuilder: (context, index) {
                final resource = resources[index];
                return ResourceGridCard(
                  resource: resource,
                  onTap: () => _openDetail(context, resource.id),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
