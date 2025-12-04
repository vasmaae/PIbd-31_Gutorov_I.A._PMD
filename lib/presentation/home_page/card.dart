part of 'home_page.dart';

typedef OnLikeCallback = void Function(String title, bool isLiked)?;

class _Card extends StatefulWidget {
  final String text;
  final String descriptionText;
  final String? imageUrl;
  final String? tip;
  final OnLikeCallback onLike;
  final VoidCallback? onTap;

  const _Card(
    this.text, {
    required this.descriptionText,
    this.imageUrl,
    this.tip,
    required this.onLike,
    this.onTap,
  });

  factory _Card.fromData(
    CardData data, {
    required OnLikeCallback onLike,
    VoidCallback? onTap,
  }) => _Card(
    data.title,
    descriptionText: data.authors,
    imageUrl: data.imageUrl,
    tip: data.rating,
    onLike: onLike,
    onTap: onTap,
  );

  @override
  State<_Card> createState() => _CardState();
}

class _CardState extends State<_Card> {
  bool isLiked = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Card(
        elevation: 6,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(20),
              ),
              child: Stack(
                children: [
                  AspectRatio(
                    aspectRatio: 1.4,
                    child: Image.network(
                      widget.imageUrl ?? '',
                      fit: BoxFit.cover,
                      width: double.infinity,
                      errorBuilder: (_, __, ___) => Container(
                        color: Colors.grey[300],
                        child: const Icon(
                          Icons.book,
                          size: 50,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                  if (widget.tip != null)
                    Positioned(
                      bottom: 12,
                      left: 12,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.orangeAccent,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          widget.tip!,
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                  Positioned(
                    bottom: 6,
                    right: 6,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 16,
                        right: 16,
                        bottom: 8,
                      ),
                      child: GestureDetector(
                        onTap: () {
                          setState(() => isLiked = !isLiked);
                          widget.onLike!(widget.text, isLiked);
                        },
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 200),
                          child: Icon(
                            isLiked ? Icons.favorite : Icons.favorite_border,
                            color: isLiked ? Colors.redAccent : Colors.grey,
                            key: ValueKey(isLiked),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.text,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    widget.descriptionText,
                    style: Theme.of(
                      context,
                    ).textTheme.bodyMedium?.copyWith(color: Colors.grey[700]),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
