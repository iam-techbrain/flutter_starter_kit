import 'package:flutter/material.dart';
import '../services/auth_service.dart';

/// Modular Header Component
///
/// Can be used as a standard AppBar or custom top navigation bar.
/// Accepts props for title, subtitle, back button, and user action buttons.
class AppHeader extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String? subtitle;
  final bool showBackButton;
  final bool showUserAvatar;
  final List<Widget>? actions;
  final VoidCallback? onBackPress;
  final VoidCallback? onAvatarPress;

  const AppHeader({
    super.key,
    required this.title,
    this.subtitle,
    this.showBackButton = true,
    this.showUserAvatar = true,
    this.actions,
    this.onBackPress,
    this.onAvatarPress,
  });

  @override
  Size get preferredSize => const Size.fromHeight(64.0);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final authService = AuthService();

    return AppBar(
      elevation: 0,
      scrolledUnderElevation: 2,
      backgroundColor: theme.colorScheme.surface,
      automaticallyImplyLeading: false,
      leading: showBackButton && Navigator.canPop(context)
          ? IconButton(
              icon: const Icon(Icons.arrow_back_ios_new, size: 20),
              tooltip: 'Back',
              onPressed: onBackPress ?? () => Navigator.maybePop(context),
            )
          : null,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              letterSpacing: 0.2,
            ),
          ),
          if (subtitle != null)
            Text(
              subtitle!,
              style: theme.textTheme.labelSmall?.copyWith(
                color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
              ),
            ),
        ],
      ),
      actions: [
        if (actions != null) ...actions!,
        if (showUserAvatar)
          ValueListenableBuilder(
            valueListenable: authService.currentUserNotifier,
            builder: (context, user, _) {
              if (user == null) return const SizedBox.shrink();
              return Padding(
                padding: const EdgeInsets.only(right: 12.0),
                child: InkWell(
                  onTap: onAvatarPress,
                  borderRadius: BorderRadius.circular(24),
                  child: CircleAvatar(
                    radius: 18,
                    backgroundColor: theme.colorScheme.primaryContainer,
                    backgroundImage: user.image.isNotEmpty ? NetworkImage(user.image) : null,
                    child: user.image.isEmpty
                        ? Text(
                            user.firstName.isNotEmpty ? user.firstName[0].toUpperCase() : 'U',
                            style: TextStyle(
                              color: theme.colorScheme.onPrimaryContainer,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        : null,
                  ),
                ),
              );
            },
          ),
      ],
    );
  }
}
