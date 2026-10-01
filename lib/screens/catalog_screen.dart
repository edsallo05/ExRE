import 'package:flutter/material.dart';

import '../data/mock_resources.dart';
import '../state/app_state.dart';
import '../widgets/category_chip.dart';
import '../widgets/resource_list_card.dart';
import '../widgets/empty_state.dart';
import '../theme/app_theme.dart';
import 'detail_screen.dart';

class CatalogScreen extends StatefulWidget {
  const CatalogScreen({super.key});

  @override
  State<CatalogScreen> createState() => _CatalogScreenState();
}

class _CatalogScreenState extends State<CatalogScreen> {
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

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
    final categories = [kCategoriaTodas, ...studyCategories];

    return Scaffold(
      appBar: AppBar(title: const Text('Catálogo')),
      body: AnimatedBuilder(
        animation: appState,
        builder: (context, _) {
          final results = appState.filteredResources;
          return SafeArea(
            child: Column(
              children: [
                // Buscador
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
                  child: TextField(
                    controller: _searchController,
                    onChanged: appState.setSearchQuery,
                    style: const TextStyle(color: AppColors.textPrimary),
                    decoration: const InputDecoration(
                      hintText: 'Buscar por título, categoría o autor',
                      prefixIcon: Icon(
                        Icons.search,
                        color: AppColors.textTertiary,
                      ),
                    ),
                  ),
                ),
                // Filtro por categoría (ListView.builder horizontal)
                SizedBox(
                  height: 44,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: categories.length,
                    itemBuilder: (context, index) {
                      final cat = categories[index];
                      return CategoryChip(
                        label: cat,
                        selected: appState.selectedCategory == cat,
                        color: cat == kCategoriaTodas
                            ? AppColors.primary
                            : AppColors.forCategory(cat),
                        onTap: () => appState.setCategory(cat),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '${results.length} recurso(s) encontrados',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                // Lista principal (ListView.separated)
                Expanded(
                  child: results.isEmpty
                      ? const EmptyState(
                          icon: Icons.search_off_rounded,
                          title: 'Sin resultados',
                          message: 'No hay recursos que coincidan con tu búsqueda o filtro.',
                        )
                      : ListView.separated(
                          padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
                          itemCount: results.length,
                          separatorBuilder: (_, _) =>
                              const SizedBox(height: 10),
                          itemBuilder: (context, index) {
                            final resource = results[index];
                            return ResourceListCard(
                              resource: resource,
                              onTap: () => _openDetail(context, resource.id),
                            );
                          },
                        ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
