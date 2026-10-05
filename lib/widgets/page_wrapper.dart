import 'package:flutter/material.dart';

/// Generic PageWrapper Component
///
/// Corresponds to React's Container/Layout wrapper with 'children' or 'child' prop.
/// Provides a consistent layout structure, safe area, background, scroll behavior,
/// and optional pull-to-refresh.
class PageWrapper extends StatelessWidget {
  /// Single child widget (like React's children)
  final Widget? child;

  /// Or multiple children rendered in a Column / ListView
  final List<Widget>? children;

  final PreferredSizeWidget? appBar;
  final Widget? bottomNavigationBar;
  final EdgeInsetsGeometry padding;
  final bool isScrollable;
  final Future<void> Function()? onRefresh;
  final Color? backgroundColor;
  final Widget? floatingActionButton;

  const PageWrapper({
    super.key,
    this.child,
    this.children,
    this.appBar,
    this.bottomNavigationBar,
    this.padding = const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
    this.isScrollable = true,
    this.onRefresh,
    this.backgroundColor,
    this.floatingActionButton,
  }) : assert(
          child != null || children != null,
          'Either child or children must be provided to PageWrapper',
        );

  @override
  Widget build(BuildContext context) {
    Widget content;

    if (children != null) {
      content = isScrollable
          ? ListView(
              padding: padding,
              physics: const AlwaysScrollableScrollPhysics(),
              children: children!,
            )
          : Padding(
              padding: padding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: children!,
              ),
            );
    } else {
      content = isScrollable
          ? SingleChildScrollView(
              padding: padding,
              physics: const AlwaysScrollableScrollPhysics(),
              child: child!,
            )
          : Padding(
              padding: padding,
              child: child!,
            );
    }

    if (onRefresh != null) {
      content = RefreshIndicator(
        onRefresh: onRefresh!,
        color: Theme.of(context).colorScheme.primary,
        child: content,
      );
    }

    return Scaffold(
      backgroundColor: backgroundColor ?? Theme.of(context).scaffoldBackgroundColor,
      appBar: appBar,
      body: SafeArea(child: content),
      bottomNavigationBar: bottomNavigationBar,
      floatingActionButton: floatingActionButton,
    );
  }
}
