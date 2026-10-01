import 'package:flutter/material.dart';

import 'state/app_state.dart';
import 'theme/app_theme.dart';
import 'screens/main_shell.dart';

void main() {
  runApp(const ExreApp());
}

class ExreApp extends StatefulWidget {
  const ExreApp({super.key});

  @override
  State<ExreApp> createState() => _ExreAppState();
}

class _ExreAppState extends State<ExreApp> {
  final AppState _appState = AppState();

  @override
  Widget build(BuildContext context) {
    return AppStateScope(
      appState: _appState,
      child: MaterialApp(
        title: 'ExRE - Explorador de Recursos de Estudio',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.theme,
        home: const MainShell(),
      ),
    );
  }
}
