import 'package:flutter/material.dart';
import 'package:kids_clouds/ui/screens/agenda_screen.dart';
import 'package:kids_clouds/ui/screens/home_screen.dart';
import 'package:kids_clouds/core/theme.dart';

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
    final bool isDesktop = MediaQuery.of(context).size.width >= 600; // Define breakpoint for desktop/tablet

    return Scaffold(
      appBar: AppBar(
        title: Text(_selectedPage == AppPage.home ? 'Inicio' : 'Agenda diaria'),
      ),
      drawer: isDesktop ? null : _buildAppDrawer(), // Show Drawer only on mobile
      body: Row(
        children: [
          if (isDesktop) _buildAppDrawer(), // On desktop, show drawer as fixed column
          Expanded(child: _getPage()),
        ],
      ),
    );
  }

  // Builds the Drawer widget
  Widget _buildAppDrawer() {
    return Drawer(
      // Apply responsive padding to Drawer ListView
      child: ListView(
        padding: AppTheme.responsivePadding(context),
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Theme.of(context).colorScheme.primary),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'Kids Clouds',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimary,
                    fontSize: AppTheme.responsiveSize(context, 20, 24),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Image.network(
                  'https://kidsnclouds.es/wp-content/uploads/2024/08/KNC-Sergio-Mix2-1.png',
                  width: 200,
                  height: 200,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(Icons.error, size: 100);
                  },
                ),
              ],
            ),
          ),
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
          // You can add more drawer items here
        ],
      ),
    );
  }
}
