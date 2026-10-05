import 'package:flutter/material.dart';

/// Modular Footer Component
///
/// Can serve as either a Bottom Navigation Bar or a bottom status/links footer.
/// Accepts props for active index, callbacks, and optional extra widgets.
class AppFooter extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int>? onTabSelected;
  final bool showBottomNav;

  const AppFooter({
    super.key,
    this.currentIndex = 0,
    this.onTabSelected,
    this.showBottomNav = true,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (showBottomNav) {
      return NavigationBar(
        selectedIndex: currentIndex,
        onDestinationSelected: onTabSelected,
        elevation: 3,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.storefront_outlined),
            selectedIcon: Icon(Icons.storefront),
            label: 'Products',
          ),
          NavigationDestination(
            icon: Icon(Icons.people_outline),
            selectedIcon: Icon(Icons.people),
            label: 'Community',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      );
    }

    // Default minimalist footer block
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.4),
        border: Border(
          top: BorderSide(
            color: theme.colorScheme.outlineVariant.withValues(alpha: 0.4),
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'DummyJSON Learner App',
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
            ),
          ),
          Text(
            'Flutter • Modular Architecture',
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
