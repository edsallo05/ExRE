import 'package:flutter/material.dart';

import '../models/resource.dart';
import '../state/app_state.dart';
import '../theme/app_theme.dart';

class ProgressScreen extends StatelessWidget {
  const ProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = AppStateScope.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Progreso')),
      body: AnimatedBuilder(
        animation: appState,
        builder: (context, _) {
          final percent = appState.completedPercent;
          final byCategory = appState.completedByCategory;
          final completed = appState.completedResources;

          return SafeArea(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                // Resumen general
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Progreso general',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            Text(
                              '${(percent * 100).round()}%',
                              style: Theme.of(context).textTheme.headlineSmall
                                  ?.copyWith(color: AppColors.success),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: LinearProgressIndicator(
                            value: percent,
                            minHeight: 10,
                            backgroundColor: AppColors.border,
                            valueColor: const AlwaysStoppedAnimation(
                              AppColors.success,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          '${appState.completedCount} completados · '
                          '${appState.pendingCount} pendientes',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Último evento de ciclo de vida
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(14),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.history,
                          color: AppColors.primaryLight,
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            appState.lifecycleHistory.isEmpty
                                ? 'Sin eventos de ciclo de vida registrados.'
                                : 'Último evento: ${appState.lifecycleHistory.first}',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                Text(
                  'Resumen por categoría',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 10),
                ...byCategory.entries.map((entry) {
                  final color = AppColors.forCategory(entry.key);
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Row(
                      children: [
                        Container(
                          width: 10,
                          height: 10,
                          decoration: BoxDecoration(
                            color: color,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            entry.key,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ),
                        Text(
                          '${entry.value}',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ],
                    ),
                  );
                }),
                const SizedBox(height: 10),

                Text(
                  'Recursos completados',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 10),
                if (completed.isEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Text(
                      'Aún no has completado ningún recurso.',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  )
                else
                  ...completed.map(
                    (r) => Card(
                      margin: const EdgeInsets.only(bottom: 8),
                      child: ListTile(
                        leading: Icon(r.type.icon, color: r.color),
                        title: Text(r.title),
                        subtitle: Text(r.category),
                        trailing: const Icon(
                          Icons.check_circle,
                          color: AppColors.success,
                        ),
                      ),
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
