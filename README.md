# ExRE — Explorador de Recursos de Estudio

App Flutter para Android desarrollada para la asignatura **Programación para Dispositivos Móviles**.

Permite consultar recursos de aprendizaje, filtrarlos por categoría, buscarlos, ver su detalle, marcarlos como favoritos, marcarlos como completados y revisar el progreso general. Todos los datos son locales (no requiere servidor, base de datos remota ni autenticación).

## Requisitos previos

- Flutter SDK (canal estable, 3.x)
- Un emulador Android configurado (Android Studio → Device Manager) o un dispositivo físico con depuración USB habilitada

Verifica que todo esté listo con:

```bash
flutter doctor
```

## Cómo ejecutar el proyecto

1. Clona o descarga este repositorio.
2. Instala las dependencias:
   ```bash
   flutter pub get
   ```
3. Con un emulador o dispositivo conectado, confirma que Flutter lo detecta:
   ```bash
   flutter devices
   ```
4. Ejecuta la app:
   ```bash
   flutter run
   ```

Durante la ejecución puedes usar:
- `r` → hot reload (aplica cambios de código sin reiniciar la app)
- `R` → hot restart
- `q` → salir

## Estructura del proyecto

```
lib/
├── main.dart                  # Punto de entrada, arma el árbol de widgets
├── theme/
│   └── app_theme.dart         # Colores y estilos globales
├── models/
│   └── resource.dart          # Modelo StudyResource y enum ResourceType
├── data/
│   └── mock_resources.dart    # 22 recursos de prueba locales
├── state/
│   └── app_state.dart         # Estado global (ChangeNotifier + InheritedNotifier)
├── widgets/                   # Widgets reutilizables (tarjetas, chips, stats, etc.)
└── screens/                   # Las 6 pantallas + el shell de navegación
```

## Pantallas

1. **Inicio** — resumen de la app, estado del ciclo de vida, contadores y accesos rápidos.
2. **Catálogo** — búsqueda, filtro por categoría y listado de recursos.
3. **Galería** — cuadrícula de recursos (2 columnas).
4. **Detalle** — información completa del recurso, favorito y completado.
5. **Favoritos** — recursos marcados como favoritos.
6. **Progreso** — porcentaje completado, resumen por categoría y lista de completados.

## Estado y manejo de datos

El estado de la app (recursos, favoritos, completados, filtros, ciclo de vida) se maneja con `ChangeNotifier` del propio SDK de Flutter, expuesto a través de un `InheritedNotifier` personalizado (`AppStateScope`). No se usa ningún paquete externo de manejo de estado.

## Navegación

Las 5 pantallas principales (Inicio, Catálogo, Galería, Favoritos, Progreso) viven dentro de un `IndexedStack` controlado por un `BottomNavigationBar`. La pantalla de Detalle se abre con `Navigator.push` desde Catálogo, Galería o Favoritos, y se cierra con `Navigator.pop`.
