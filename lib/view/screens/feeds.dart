import 'package:flutter/material.dart';
import 'package:podcats_player/data/feed.dart';
import 'package:podcats_player/service/feed_service/feed_service.dart';
import 'package:podcats_player/view/feed_view.dart';

class FeedsPage extends StatefulWidget {
  const FeedsPage({super.key, required this.title});

  final String title;

  @override
  State<FeedsPage> createState() => _FeedsPageState();
}

class _FeedsPageState extends State<FeedsPage> {
  // List<Feed> feeds = [];
  Feed? feeds;

  @override
  Widget build(BuildContext context) => Stack(
        children: <Widget>[
          feeds == null ? const Placeholder() : FeedView(feed: feeds!),
          Positioned(
            right: 10,
            bottom: 10,
            child: IconButton(
              onPressed: _incrementCounter,
              icon: const Icon(Icons.add),
            ),
          )
        ],
      );

  void _incrementCounter() {
    const FeedService()
        .getFrom(Uri.parse("https://critrole.libsyn.com/rss"))
        .then((feed) => feeds = feed)
        .then((value) => setState(() {}));
  }
}
