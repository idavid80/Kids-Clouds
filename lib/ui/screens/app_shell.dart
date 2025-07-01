
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:kids_clouds/core/theme_provider.dart';
import 'package:kids_clouds/data/mock_data.dart';
import 'package:kids_clouds/service/camara_service.dart';
import 'package:kids_clouds/ui/responsive/layout_helper.dart';
import 'package:kids_clouds/ui/screens/agenda_screen.dart';
import 'package:kids_clouds/ui/screens/home_screen.dart';
import 'package:kids_clouds/core/theme.dart';
import 'package:provider/provider.dart';

enum AppPage { home, agenda }

// AppShell: Main container of the app that manages navigation
class AppShell extends StatefulWidget {
  final AppPage initialPage; // Allows specifying the initial page

  const AppShell({super.key, this.initialPage = AppPage.home});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  late AppPage _selectedPage; // Using late to initialize in initState
  final parent = MockData.parent; // Get parent data
  String? _profileImagePath;
  final CameraGalleryService _imageService = CameraGalleryService();

  @override
  void initState() {

    super.initState();
    _selectedPage = widget.initialPage; // Initialize with the page passed to constructor
  }

  // Changes the selected page and closes the Drawer if open on mobile
  void _selectPage(AppPage page) {
    setState(() {
      _selectedPage = page;
    });
    // Only close the drawer if on mobile (width < 600)
    if (MediaQuery.of(context).size.width < 600) {
      Navigator.pop(context);
    }
  }

  // Returns the widget for the current selected page
  Widget _getPage() {
    switch (_selectedPage) {
      case AppPage.home:
        return const HomeScreenContent();
      case AppPage.agenda:
        return const AgendaScreenContent();
    }
  }

  @override
  Widget build(BuildContext context) {
    // Determines if it's a desktop (or large tablet) screen
    final bool isDesktop = LayoutHelper.isDesktop(context);
    //final bool isDesktop = MediaQuery.of(context).size.width >= AppTheme.responsiveSize(context, 600, 1000); // Use responsiveSize for the breakpoint
    return Scaffold(
      appBar: AppBar(
        title: Text(_selectedPage == AppPage.home ? 'Inicio' : 'Agenda diaria'),
      ),
      drawer: isDesktop ? null : _buildAppDrawer(context, isDesktop), // Pass isDesktop to _buildAppDrawer
      body: Row(
        children: [
          if (isDesktop) _buildAppDrawer(context, isDesktop), // On desktop, show drawer as fixed column
          Expanded(child: _getPage()),
        ],
      ),
    );
  }

  // Builds the Drawer widget
  Widget _buildAppDrawer(BuildContext context, bool isDesktop) {
    // Access the ThemeProvider
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Drawer(
      width: AppTheme.responsiveSize(context, 250, 300), // Responsive width for the drawer
      child: ListView(
        padding: AppTheme.responsivePadding(context),
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Theme.of(context).colorScheme.primary),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                //mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Kids Clouds',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onPrimary,
                      fontSize: AppTheme.responsiveSize(context, 20, 24),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8), // Space between text and image
                  Image.network(
                    'https://kidsnclouds.es/wp-content/uploads/2024/08/KNC-Sergio-Mix2-1.png',
                    width: AppTheme.responsiveSize(context, 150, 200),
                    height: AppTheme.responsiveSize(context, 75, 100),
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(Icons.error, size: 50, color: Colors.red);
                    },
                  ),
                ],
              ),
            ),
          ),GestureDetector(
            onTap: () async {
              final path = await _imageService.selectPhoto();
              if (path != null) {
                setState(() {
                  _profileImagePath = path;
                });
              }
            },
            child: Container(
              width: AppTheme.responsiveSize(context, 80, 100),
              height: AppTheme.responsiveSize(context, 80, 100),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: _profileImagePath != null
                      ? FileImage(File(_profileImagePath!))
                      : const AssetImage('assets/images/defaul_avatar.jpg') as ImageProvider,
                  fit: BoxFit.contain, // Aquí controlas que se vea completa
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'Luis López',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          // Parent Information (Avatar and Name)
          /*
          if (parent != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: AppTheme.responsiveSize(context, 20, 24),
                    backgroundImage: NetworkImage(parent.avatarUrl),
                    onBackgroundImageError: (exception, stackTrace) {
                      debugPrint('Error loading parent avatar: $exception');
                    },
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      parent.name,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),*/
          const Divider(), // Visual separator after parent info

          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Inicio'),
            selected: _selectedPage == AppPage.home,
            onTap: () => _selectPage(AppPage.home),
            selectedTileColor: Theme.of(context).colorScheme.primary.withAlpha((255 * 0.1).round()),
          ),
          ListTile(
            leading: const Icon(Icons.calendar_today),
            title: const Text('Agenda diaria'),
            selected: _selectedPage == AppPage.agenda,
            onTap: () => _selectPage(AppPage.agenda),
            selectedTileColor: Theme.of(context).colorScheme.primary.withAlpha((255 * 0.1).round()),
          ),
          const Divider(), // Visual separator before dark mode button

          // Dark Mode Button
          InkWell(
            onTap: () {
              // Toggle theme when tapped
              themeProvider.toggleTheme(themeProvider.themeMode != ThemeMode.dark);
            },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: AppTheme.responsiveSize(context, 16, 24), vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    themeProvider.themeMode == ThemeMode.dark ? Icons.dark_mode : Icons.light_mode,
                    size: AppTheme.responsiveSize(context, 24, 28), // Make icon size responsive
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      'Modo Oscuro',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),//  TODO: Toggle Switch
                  ),
                ],
              ),
            ),
          ),
          const Divider(), // Visual separator before logout button
          // Logout Button
          ListTile(
            leading: Icon(Icons.logout, color: Theme.of(context).colorScheme.error),// Logout icon
            title: Text(
              'Cerrar Sesión',
              style: TextStyle(color: Theme.of(context).colorScheme.error),
            ),
            onTap: () {
              // Logout logic (here only a debugPrint)
              debugPrint('User logged out!');
              // You could navigate to a login screen, clear authentication states, etc.
              // For example: Navigator.of(context).pushReplacementNamed('/login');
              // For this example, we just close the drawer and go back to the home screen
              _selectPage(AppPage.home); // Or navigate to a login screen
            },
          ),
        ],
      ),
    );
  }
}
