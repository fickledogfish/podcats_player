class FeedItem {
  final String id;

  final String title;
  final DateTime date;
  final int length;
  final Uri? url;

  const FeedItem({
    required this.id,
    required this.title,
    required this.date,
    required this.length,
    required this.url,
  });

  @override
  String toString() => '[$date] $title';
}
