import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Stateful Scaffold with Navigation
class StatefulScaffoldWithNavigation extends StatelessWidget {
  ///
  const StatefulScaffoldWithNavigation({
    required StatefulNavigationShell navigationShell,
    Key? key,
  })  : _navigationShell = navigationShell,
        super(
          key: key ?? const ValueKey<String>('ScaffoldWithNestedNavigation'),
        );

  final StatefulNavigationShell _navigationShell;

  void _goBranch(int index) {
    _navigationShell.goBranch(
      index,
      // A common pattern when using bottom navigation bars is to support
      // navigating to the initial location when tapping the item that is
      // already active. This example demonstrates how to support this behavior,
      // using the initialLocation parameter of goBranch.
      initialLocation: index == _navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _navigationShell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: _navigationShell.currentIndex,
        destinations: const [
          NavigationDestination(label: 'Section A', icon: Icon(Icons.home)),
          NavigationDestination(label: 'Section B', icon: Icon(Icons.settings)),
        ],
        onDestinationSelected: _goBranch,
      ),
    );
  }
}
