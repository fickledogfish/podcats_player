import 'package:podcats_player/data/feed.dart';
import 'package:podcats_player/data/feed_item.dart';
import 'package:webfeed/webfeed.dart';
import 'package:xml/xml.dart';

typedef FeedParserFunction = Feed Function(String);

enum FeedParserStrategy {
  automatic,
  atom,
  rss;

  FeedParserFunction get parse {
    switch (this) {
      case automatic:
        return _automaticParse;

      case atom:
        return _parseAtomFeed;

      case rss:
        return _parseRssFeed;
    }
  }
}

Feed _parseAtomFeed(String feed) {
  throw UnimplementedError();
}

Feed _parseRssFeed(String feed) {
  final parsed = RssFeed.parse(feed);
  final items = parsed.items
      ?.map((RssItem rssItem) => FeedItem(
            id: rssItem.guid ?? "",
            title: rssItem.title ?? "",
            date: rssItem.pubDate ?? DateTime.now(),
            length: rssItem.enclosure?.length ?? 0,
            url: Uri.tryParse(rssItem.enclosure?.url ?? ""),
          ))
      .toList();

  return Feed(
    title: parsed.title ?? "",
    imageUrl: Uri.tryParse(parsed.image?.url ?? ""),
    items: items ?? [],
    buildDate: DateTime.tryParse(parsed.lastBuildDate ?? "") ?? DateTime.now(),
    type: FeedType.rss,
  );
}

extension WebFeedIterable<T> on Iterable<T> {
  T? get firstOrNull => isEmpty ? null : first;
}

// Feed? _manuallyParseRssFeed(XmlDocument document) {
//   final rss = document.findElements('rss').firstOrNull ??
//       document.findElements('rdf:RDF').firstOrNull;
//
//   final channel = rss?.findElements('channel').firstOrNull;
//
//   return Feed(
//     title: channel?.findElements('title').firstOrNull?.text ?? "",
//   );
// }

Feed _automaticParse(String feed) {
  try {
    final document = XmlDocument.parse(feed);
    final rootElementName = document.rootElement.name.toString();

    if (rootElementName == "rss") {
      return _parseRssFeed(feed);
      // return _manuallyParseRssFeed(document);
    } else if (rootElementName == "feed" &&
        document.rootElement.namespaceUri == "http://www.w3.org/2005/Atom") {
      return _parseAtomFeed(feed);
    }

    throw Exception("Unknown feed type");
  } on XmlException catch (_) {
    throw Exception("failed to parse xml document");
  }
}
