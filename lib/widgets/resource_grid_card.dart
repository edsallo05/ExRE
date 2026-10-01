import 'package:flutter/material.dart';

import '../models/resource.dart';
import '../state/app_state.dart';
import '../theme/app_theme.dart';

class ResourceGridCard extends StatelessWidget {
  final StudyResource resource;
  final VoidCallback onTap;

  const ResourceGridCard({
    super.key,
    required this.resource,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final appState = AppStateScope.of(context);
    return AnimatedBuilder(
      animation: appState,
      builder: (context, _) {
        final isFav = appState.isFavorite(resource.id);
        final isDone = appState.isCompleted(resource.id);
        return Card(
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: onTap,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Portada
                Expanded(
                  child: Container(
                    width: double.infinity,
                    color: resource.color.withValues(alpha: 0.25),
                    child: Stack(
                      children: [
                        Center(
                          child: Icon(
                            resource.type.icon,
                            color: resource.color,
                            size: 32,
                          ),
                        ),
                        if (isFav)
                          const Positioned(
                            top: 6,
                            right: 6,
                            child: Icon(
                              Icons.favorite,
                              color: AppColors.favorite,
                              size: 18,
                            ),
                          ),
                        if (isDone)
                          const Positioned(
                            top: 6,
                            left: 6,
                            child: Icon(
                              Icons.check_circle,
                              color: AppColors.success,
                              size: 18,
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 8, 10, 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        resource.title,
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(fontSize: 13),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${resource.category} · ${resource.durationMinutes} min',
                        style: Theme.of(context).textTheme.bodySmall,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
