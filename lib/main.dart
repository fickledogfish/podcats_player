import 'dart:io';

import 'package:flutter/material.dart';
import 'package:podcats_player/service/database_storage/database_storage_provider.dart';
import 'package:podcats_player/view/components/split_scaffold.dart';
import 'package:podcats_player/view/screens/bookmarks.dart';
import 'package:podcats_player/view/screens/downloads.dart';
import 'package:podcats_player/view/screens/feeds.dart';
import 'package:podcats_player/view/screens/menu.dart';
import 'package:podcats_player/view/screens/settings.dart';
import 'package:podcats_player/view/theme/themes/default.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  DatabaseStorageProvider.connect().then((provider) {
    provider.set();
  });

  _initSqflite();
  runApp(PodcastApp());
}

class PodcastApp extends StatelessWidget {
  final double _drawerWidth = 250;

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _navigatorKey = GlobalKey<NavigatorState>();

  PodcastApp({super.key});

  bool get _isDrawerOpen => _scaffoldKey.currentState?.isDrawerOpen ?? false;

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'Flutter Demo',
        theme: defaultTheme.light,
        darkTheme: defaultTheme.dark,
        themeMode: ThemeMode.system,
        home: SplitScaffold(
          scaffoldKey: _scaffoldKey,
          navigatorKey: _navigatorKey,
          drawerWidth: _drawerWidth,
          menu: Menu(
            isInsideDrawer: () => _isDrawerOpen,
            navigatorKey: _navigatorKey,
          ),
          onGenerateRoute: _onGenerateRoute,
        ),
      );

  Route<dynamic>? _onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (context) {
          return const FeedsPage(title: 'Flutter Demo Home Page');
        });

      case '/bookmarks':
        return MaterialPageRoute(builder: (context) {
          return const BookmarksPage();
        });

      case '/downloads':
        return MaterialPageRoute(builder: (context) {
          return const DownloadsPage();
        });

      case '/settings':
        return MaterialPageRoute(builder: (context) {
          return const SettingsPage();
        });
    }

    return null;
  }
}

void _initSqflite() {
  if (Platform.isWindows || Platform.isLinux) {
    sqfliteFfiInit();
  }

  databaseFactory = databaseFactoryFfi;
}
