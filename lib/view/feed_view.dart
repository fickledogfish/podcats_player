import 'package:flutter/material.dart';
import 'package:podcats_player/data/feed.dart';
import 'package:podcats_player/data/feed_item.dart';
import 'package:podcats_player/view/components/feed_image_view.dart';
import 'package:podcats_player/view/formatter/date_formatter.dart';
import 'package:podcats_player/view/formatter/file_size_formatter.dart';
import 'package:podcats_player/view/formatter/time_formatter.dart';

class FeedView extends StatelessWidget {
  final Feed feed;

  const FeedView({
    super.key,
    required this.feed,
  });

  @override
  Widget build(BuildContext context) => ListView(
        padding: const EdgeInsets.all(15),
        children: [
          _HeaderView(feed: feed),
          const SizedBox(height: 50),
          ListView.separated(
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            padding: EdgeInsets.zero,
            itemCount: feed.items.length,
            separatorBuilder: (_, __) => const Divider(
              indent: 30,
              endIndent: 30,
            ),
            itemBuilder: (_, index) => _FeedItemView(item: feed.items[index]),
          ),
        ],
      );
}

class _HeaderView extends StatelessWidget {
  final Feed feed;

  final DateFormatter dateFormatter;

  const _HeaderView({
    super.key,
    required this.feed,
    this.dateFormatter = const DateFormatter(),
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        FeedImageView(imageUrl: feed.imageUrl),
        const SizedBox(width: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              feed.title,
              style: theme.textTheme.headlineMedium,
            ),
            const SizedBox(height: 10),
            Text(
              "${feed.items.length} items",
              style: theme.textTheme.titleSmall,
            ),
            const SizedBox(height: 5),
            Text(
              "Last updated: ${dateFormatter.dateAndTime(feed.buildDate)}",
              style: theme.textTheme.titleSmall,
            ),
          ],
        )
      ],
    );
  }
}

class _FeedItemView extends StatelessWidget {
  final FeedItem item;
  final DateFormatter dateFormatter;
  final TimeFormatter timeFormatter;
  final FileSizeFormatter fileSizeFormatter;

  const _FeedItemView({
    required this.item,
    this.dateFormatter = const DateFormatter(),
    this.timeFormatter = const TimeFormatter(),
    this.fileSizeFormatter = const FileSizeFormatter(),
  });

  @override
  Widget build(BuildContext context) {
    final date = dateFormatter.simplifiedDate(item.date);
    final size = fileSizeFormatter.fromBytes(item.length);

    return GestureDetector(
      onLongPress: _didPressAndHoldCard,
      behavior: HitTestBehavior.opaque,
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  "$date - $size",
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(height: 5),
                Text(
                  item.title,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                const SizedBox(height: 5),
                Text(timeFormatter.fromSeconds(item.length)),
              ],
            ),
          ),
          IconButton(
            onPressed: _didPressDownload,
            icon: const Icon(Icons.download_outlined),
          ),
        ],
      ),
    );
  }

  void _didPressDownload() {
    print("nope");
  }

  void _didPressAndHoldCard() {
    print(item.title);
  }
}
