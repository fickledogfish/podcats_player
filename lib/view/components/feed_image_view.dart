import 'package:flutter/material.dart';

class FeedImageView extends StatelessWidget {
  final Uri? imageUrl;

  final double height;
  final double width;
  final double borderRadius;

  final Map<String, String> headers;

  const FeedImageView({
    super.key,
    required this.imageUrl,
    this.height = 110,
    this.width = 110,
    this.borderRadius = 10,
    this.headers = const {},
  });

  @override
  Widget build(BuildContext context) => ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: SizedBox(
          width: width,
          height: height,
          child: Image.network(
            imageUrl.toString(),
            headers: headers,
            loadingBuilder: _loadingBuilder,
            errorBuilder: _errorBuilder,
          ),
        ),
      );

  Widget _loadingBuilder(
    BuildContext context,
    Widget child,
    ImageChunkEvent? imageChunkEvent,
  ) =>
      imageChunkEvent == null
          ? child
          : Center(
              child: CircularProgressIndicator(
              value: imageChunkEvent.expectedTotalBytes == null
                  ? imageChunkEvent.cumulativeBytesLoaded /
                      imageChunkEvent.expectedTotalBytes!
                  : null,
            ));

  Widget _errorBuilder(
    BuildContext context,
    Object object,
    StackTrace? stackTrace,
  ) {
    final theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
          color: theme.colorScheme.errorContainer,
          borderRadius: BorderRadius.circular(borderRadius),
          border: Border.all(
            color: theme.colorScheme.error,
          )),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            color: theme.colorScheme.error,
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            "Missing image",
            style: theme.textTheme.bodyMedium!
                .copyWith(color: theme.colorScheme.error),
          )
        ],
      ),
    );
  }
}
