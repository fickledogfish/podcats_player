import 'package:flutter/widgets.dart';
import 'package:podcats_player/data/feed_item.dart';
import 'package:podcats_player/view/formatter/date_formatter.dart';

class FeedItemView extends StatelessWidget {
  final FeedItem item;
  final DateFormatter dateFormatter;

  const FeedItemView({
    super.key,
    required this.item,
    this.dateFormatter = const DateFormatter(),
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(item.title),
        Text(dateFormatter.simplifiedDate(item.date)),
      ],
    );
  }
}
