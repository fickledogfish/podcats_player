import 'package:podcats_player/data/feed.dart';
import 'package:podcats_player/service/http_client/http_client.dart';

import 'feed_parser.dart';

class FeedService {
  final HttpClient _client;

  const FeedService({
    client = const HttpClient(),
  }) : _client = client;

  Future<Feed> getFrom(
    Uri url, {
    FeedParserStrategy strategy = FeedParserStrategy.automatic,
  }) async {
    final feed = await _client.getString(url: url);
    return strategy.parse(feed);
  }

  Future<Feed> update(Feed feed) {
    return Future.error("error");
  }
}
