import 'package:flutter/material.dart';

import '../state/app_state.dart';
import '../theme/app_theme.dart';
import '../widgets/stat_card.dart';
import '../widgets/quick_access_card.dart';

class HomeScreen extends StatelessWidget {
  final ValueChanged<int> onNavigateTab;

  const HomeScreen({super.key, required this.onNavigateTab});

  String _lifecycleMessage(AppLifecycleState? state) {
    switch (state) {
      case AppLifecycleState.resumed:
        return 'La app está activa y en primer plano.';
      case AppLifecycleState.inactive:
        return 'La app está inactiva (transición en curso).';
      case AppLifecycleState.paused:
        return 'La app está en segundo plano (pausada).';
      case AppLifecycleState.detached:
        return 'La app se está cerrando o aún no se ha unido a la vista.';
      case AppLifecycleState.hidden:
        return 'La app está oculta.';
      case null:
        return 'Aplicación iniciada correctamente.';
    }
  }

  Color _lifecycleColor(AppLifecycleState? state) {
    switch (state) {
      case AppLifecycleState.resumed:
        return AppColors.success;
      case AppLifecycleState.inactive:
        return AppColors.warning;
      case AppLifecycleState.paused:
        return AppColors.danger;
      case AppLifecycleState.detached:
        return AppColors.textTertiary;
      case AppLifecycleState.hidden:
        return AppColors.textTertiary;
      case null:
        return AppColors.primary;
    }
  }

  @override
  Widget build(BuildContext context) {
    final appState = AppStateScope.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('ExRE')),
      body: AnimatedBuilder(
        animation: appState,
        builder: (context, _) {
          return SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Explorador de Recursos de Estudio',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Consulta, filtra y organiza tus recursos de aprendizaje '
                    'de Programación para Dispositivos Móviles en un solo lugar.',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 20),

                  // Indicador de ciclo de vida
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(14),
                      child: Row(
                        children: [
                          Container(
                            width: 12,
                            height: 12,
                            decoration: BoxDecoration(
                              color: _lifecycleColor(
                                appState.lastLifecycleState,
                              ),
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Estado: '
                                  '${appState.lastLifecycleState?.name ?? "inicial"}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium,
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  _lifecycleMessage(
                                    appState.lastLifecycleState,
                                  ),
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Contadores
                  Row(
                    children: [
                      StatCard(
                        value: '${appState.totalCount}',
                        label: 'Recursos',
                        icon: Icons.library_books_rounded,
                        color: AppColors.primary,
                      ),
                      const SizedBox(width: 10),
                      StatCard(
                        value: '${appState.favoriteCount}',
                        label: 'Favoritos',
                        icon: Icons.favorite_rounded,
                        color: AppColors.favorite,
                      ),
                      const SizedBox(width: 10),
                      StatCard(
                        value: '${appState.completedCount}',
                        label: 'Completados',
                        icon: Icons.check_circle_rounded,
                        color: AppColors.success,
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  Text(
                    'Accesos rápidos',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      QuickAccessCard(
                        label: 'Catálogo',
                        icon: Icons.grid_view_rounded,
                        color: AppColors.primary,
                        onTap: () => onNavigateTab(1),
                      ),
                      const SizedBox(width: 10),
                      QuickAccessCard(
                        label: 'Galería',
                        icon: Icons.photo_library_rounded,
                        color: AppColors.catSlivers,
                        onTap: () => onNavigateTab(2),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      QuickAccessCard(
                        label: 'Favoritos',
                        icon: Icons.favorite_rounded,
                        color: AppColors.favorite,
                        onTap: () => onNavigateTab(3),
                      ),
                      const SizedBox(width: 10),
                      QuickAccessCard(
                        label: 'Progreso',
                        icon: Icons.bar_chart_rounded,
                        color: AppColors.success,
                        onTap: () => onNavigateTab(4),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
