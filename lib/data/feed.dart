import 'package:podcats_player/data/feed_item.dart';

enum FeedType {
  atom,
  rss,
}

class Feed {
  final String title;
  final Uri? imageUrl;
  final List<FeedItem> items;

  final DateTime buildDate;
  final FeedType type;

  const Feed({
    required this.title,
    required this.imageUrl,
    required this.items,
    required this.buildDate,
    required this.type,
  });

  @override
  String toString() => '$title ($type) - ${items.length} items';
}
