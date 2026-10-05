import 'package:flutter/material.dart';
import '../models/user_profile.dart';
import '../services/api_service.dart';
import '../services/auth_service.dart';
import '../widgets/app_header.dart';
import '../widgets/app_footer.dart';
import '../widgets/page_wrapper.dart';
import 'login_screen.dart';

/// Page 3: User Profile / Details Page
///
/// Demonstrates:
/// - Asynchronous GET https://dummyjson.com/users using async-await & FutureBuilder
/// - Displaying authenticated user details from state
/// - Modular Parent-Child component pattern with PageWrapper, AppHeader, AppFooter
/// - Logging out and clearing application state
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late Future<List<UserProfile>> _usersFuture;

  @override
  void initState() {
    super.initState();
    _loadUsers();
  }

  void _loadUsers() {
    setState(() {
      _usersFuture = ApiService.getUsers(limit: 15);
    });
  }

  void _handleLogout() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Sign Out'),
        content: const Text('Are you sure you want to log out from DummyJSON?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              Navigator.pop(ctx);
              AuthService().logout();
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
                (route) => false,
              );
            },
            child: const Text('Sign Out'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final authService = AuthService();
    final currentUser = authService.currentUser;

    return PageWrapper(
      isScrollable: true,
      appBar: AppHeader(
        title: 'User Profile & Directory',
        subtitle: 'DummyJSON Users API',
        showBackButton: true,
        showUserAvatar: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Sign Out',
            onPressed: _handleLogout,
          ),
        ],
      ),
      bottomNavigationBar: AppFooter(
        currentIndex: 2,
        onTabSelected: (index) {
          if (index == 0) {
            Navigator.pop(context);
          }
        },
      ),
      children: [
        // 1. Current Logged-in User Profile Header Card
        Card(
          elevation: 2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 46,
                  backgroundColor: theme.colorScheme.primaryContainer,
                  backgroundImage: currentUser != null && currentUser.image.isNotEmpty
                      ? NetworkImage(currentUser.image)
                      : null,
                  child: currentUser == null
                      ? const Icon(Icons.person, size: 48)
                      : null,
                ),
                const SizedBox(height: 14),
                Text(
                  currentUser?.fullName ?? 'Guest User',
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '@${currentUser?.username ?? 'guest'} • ${currentUser?.email ?? 'no email'}',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                  ),
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  alignment: WrapAlignment.center,
                  children: [
                    Chip(
                      avatar: const Icon(Icons.verified, size: 16, color: Colors.blue),
                      label: Text(
                        authService.isAuthenticated ? 'Authenticated' : 'Offline',
                        style: const TextStyle(fontSize: 12),
                      ),
                    ),
                    if (currentUser != null)
                      Chip(
                        avatar: const Icon(Icons.wc, size: 16),
                        label: Text(
                          currentUser.gender.toUpperCase(),
                          style: const TextStyle(fontSize: 12),
                        ),
                      ),
                  ],
                ),
                const Divider(height: 32),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildStatItem(context, 'User ID', '#${currentUser?.id ?? 0}'),
                    _buildStatItem(context, 'Session', 'Active JWT'),
                    _buildStatItem(context, 'Role', 'Verified Customer'),
                  ],
                ),
              ],
            ),
          ),
        ),

        const SizedBox(height: 24),

        // Section Title: Directory from https://dummyjson.com/users
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Community Directory (Users API)',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            IconButton(
              icon: const Icon(Icons.refresh, size: 20),
              tooltip: 'Refresh Users',
              onPressed: _loadUsers,
            ),
          ],
        ),
        const SizedBox(height: 8),

        // 2. FutureBuilder asynchronously loading users from DummyJSON
        FutureBuilder<List<UserProfile>>(
          future: _usersFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Padding(
                padding: EdgeInsets.symmetric(vertical: 40.0),
                child: Center(
                  child: Column(
                    children: [
                      CircularProgressIndicator(),
                      SizedBox(height: 12),
                      Text('Fetching users from https://dummyjson.com/users...'),
                    ],
                  ),
                ),
              );
            }

            if (snapshot.hasError) {
              return Card.outlined(
                color: theme.colorScheme.errorContainer.withValues(alpha: 0.4),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Icon(Icons.error_outline, color: theme.colorScheme.error),
                      const SizedBox(height: 8),
                      Text('Error: ${snapshot.error}'),
                      TextButton(
                        onPressed: _loadUsers,
                        child: const Text('Try Again'),
                      ),
                    ],
                  ),
                ),
              );
            }

            final users = snapshot.data ?? [];
            if (users.isEmpty) {
              return const Center(child: Text('No users found.'));
            }

            return ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: users.length,
              separatorBuilder: (_, __) => const SizedBox(height: 8),
              itemBuilder: (context, index) {
                final user = users[index];
                return Card(
                  elevation: 0.5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                    side: BorderSide(
                      color: theme.colorScheme.outlineVariant.withValues(alpha: 0.3),
                    ),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
                    leading: CircleAvatar(
                      backgroundColor: theme.colorScheme.surfaceContainerHighest,
                      backgroundImage: user.image.isNotEmpty ? NetworkImage(user.image) : null,
                      child: user.image.isEmpty
                          ? Text(user.firstName.isNotEmpty ? user.firstName[0] : 'U')
                          : null,
                    ),
                    title: Text(
                      user.fullName,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    subtitle: Text('${user.companyTitle} @ ${user.companyName} • ${user.email}'),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 14),
                    onTap: () {
                      _showUserDetailsDialog(context, user);
                    },
                  ),
                );
              },
            );
          },
        ),

        const SizedBox(height: 32),
      ],
    );
  }

  Widget _buildStatItem(BuildContext context, String label, String value) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Text(
          value,
          style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
          ),
        ),
      ],
    );
  }

  void _showUserDetailsDialog(BuildContext context, UserProfile user) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              radius: 40,
              backgroundImage: user.image.isNotEmpty ? NetworkImage(user.image) : null,
            ),
            const SizedBox(height: 12),
            Text(
              user.fullName,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              '@${user.username}',
              style: TextStyle(color: Colors.grey.shade600),
            ),
            const Divider(height: 24),
            _buildDialogRow('Email', user.email),
            _buildDialogRow('Phone', user.phone),
            _buildDialogRow('Age', '${user.age} yrs'),
            _buildDialogRow('Blood Group', user.bloodGroup),
            _buildDialogRow('Company', '${user.companyTitle} at ${user.companyName}'),
            _buildDialogRow('Location', '${user.city}, ${user.state}'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  Widget _buildDialogRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 90,
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(color: Colors.grey.shade800, fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }
}
