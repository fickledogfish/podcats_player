import 'package:flutter/material.dart';
import 'package:podcats_player/view/components/menu_button.dart';
import 'package:podcats_player/view/components/search_text_field.dart';

typedef MenuDrawerDetector = bool Function();

class Menu extends StatefulWidget {
  final MenuDrawerDetector _isInsideDrawer;
  final GlobalKey<NavigatorState>? _navigatorKey;

  const Menu({
    super.key,
    required MenuDrawerDetector isInsideDrawer,
    GlobalKey<NavigatorState>? navigatorKey,
  })  : _isInsideDrawer = isInsideDrawer,
        _navigatorKey = navigatorKey;

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  @override
  Widget build(BuildContext context) => ListView(
        padding: const EdgeInsets.all(10),
        children: [
          SearchTextField(
            hintText: 'Search',
            callback: _didSearchFor,
          ),
          const SizedBox(height: 10),
          MenuButton.icon(
            title: 'Feeds',
            icon: Icons.rss_feed,
            onPress: _didPressFeeds,
          ),
          MenuButton.icon(
            title: 'Bookmarks',
            icon: Icons.bookmark,
            onPress: _didPressBookmarks,
          ),
          MenuButton.icon(
            title: 'Downloads',
            icon: Icons.download,
            onPress: _didPressDownloads,
          ),
          MenuButton.icon(
            title: 'Settings',
            icon: Icons.settings,
            onPress: _didPressSettings,
          ),
          const Divider(indent: 10, endIndent: 10),
          ListView.builder(
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            padding: EdgeInsets.zero,
            itemCount: 100,
            itemBuilder: (context, index) => MenuButton.icon(
              title: 'alkdjklj - $index',
              icon: Icons.question_mark_sharp,
              onPress: () => _didSelectFeedItem(index),
            ),
          )
        ],
      );

  void _closeDrawer() {
    if (widget._isInsideDrawer()) {
      Navigator.pop(context);
    }
  }

  void _didSearchFor(String text) {
    _closeDrawer();
    print(text);
  }

  void _didPressFeeds() {
    widget._navigatorKey?.currentState?.pushReplacementNamed('/');
    _closeDrawer();
  }

  void _didPressDownloads() {
    widget._navigatorKey?.currentState?.pushReplacementNamed('/downloads');
    _closeDrawer();
  }

  void _didPressBookmarks() {
    widget._navigatorKey?.currentState?.pushReplacementNamed('/bookmarks');
    _closeDrawer();
  }

  void _didPressSettings() {
    widget._navigatorKey?.currentState?.pushReplacementNamed('/settings');
    _closeDrawer();
  }

  void _didSelectFeedItem(int index) {
    print(index.toString());
  }
}
