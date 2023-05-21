import 'package:flutter/material.dart';

typedef RouterGeneratorFn = Route<dynamic>? Function(RouteSettings);

class SplitScaffold extends StatelessWidget {
  final Widget menu;
  final Widget? floatingActionButton;

  final GlobalKey<ScaffoldState>? scaffoldKey;

  final GlobalKey<NavigatorState>? navigatorKey;
  final String initialRoute;
  final RouterGeneratorFn onGenerateRoute;

  final int breakpoint;
  final double drawerWidth;

  const SplitScaffold({
    super.key,
    required this.menu,
    required this.onGenerateRoute,
    this.initialRoute = '/',
    this.scaffoldKey,
    this.navigatorKey,
    this.floatingActionButton,
    this.breakpoint = 700,
    this.drawerWidth = 120,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final shouldMoveMenuToDrawer = width < breakpoint;

    return Scaffold(
      key: scaffoldKey,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        toolbarHeight: 0,
      ),
      drawer: shouldMoveMenuToDrawer
          ? _Drawer(drawerWidth: drawerWidth, menu: menu)
          : null,
      body: Stack(
        children: [
          _Body(
            menuWidth: drawerWidth,
            menu: shouldMoveMenuToDrawer ? null : menu,
            navigatorKey: navigatorKey,
            initialRoute: initialRoute,
            onGenerateRoute: onGenerateRoute,
          ),
          if (shouldMoveMenuToDrawer)
            IconButton(
              onPressed: _didPressMenu,
              icon: const Icon(Icons.menu),
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              focusColor: Colors.transparent,
              hoverColor: Colors.transparent,
            )
        ],
      ),
      floatingActionButton: floatingActionButton,
    );
  }

  void _didPressMenu() {
    scaffoldKey?.currentState?.openDrawer();
  }
}

class _Drawer extends StatelessWidget {
  final double drawerWidth;
  final Widget menu;

  const _Drawer({
    required this.drawerWidth,
    required this.menu,
  });

  @override
  Widget build(BuildContext context) => Container(
        color: Theme.of(context).colorScheme.background,
        child: SizedBox(
          width: drawerWidth,
          child: menu,
        ),
      );
}

class _Body extends StatelessWidget {
  final double menuWidth;
  final Widget? menu;

  final GlobalKey<NavigatorState>? navigatorKey;
  final String initialRoute;
  final RouterGeneratorFn onGenerateRoute;

  const _Body({
    required this.menuWidth,
    required this.menu,
    required this.initialRoute,
    required this.onGenerateRoute,
    this.navigatorKey,
  });

  @override
  Widget build(BuildContext context) => menu == null
      ? Navigator(
          key: navigatorKey,
          initialRoute: initialRoute,
          onGenerateRoute: onGenerateRoute,
        )
      : Row(
          children: [
            SizedBox(
              width: menuWidth,
              child: menu,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: VerticalDivider(width: 1),
            ),
            Expanded(
              child: Navigator(
                key: navigatorKey,
                initialRoute: initialRoute,
                onGenerateRoute: onGenerateRoute,
              ),
            ),
          ],
        );
}
