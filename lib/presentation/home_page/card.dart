part of 'home_page.dart';

typedef OnLikeCallback = void Function(int? id, String title, bool isLiked)?;

class _Card extends StatelessWidget {
  final String text;
  final String descriptionText;
  final String? imageUrl;
  final String? tip;
  final OnLikeCallback onLike;
  final VoidCallback? onTap;
  final int? id;
  final bool isLiked;

  const _Card(
    this.text, {
    required this.descriptionText,
    this.imageUrl,
    this.tip,
    this.onLike,
    this.onTap,
    this.id,
    this.isLiked = false,
  });

  factory _Card.fromData(
    CardData data, {
    OnLikeCallback onLike,
    VoidCallback? onTap,
    bool isLiked = false,
  }) => _Card(
    data.title,
    descriptionText: data.authors,
    imageUrl: data.imageUrl,
    tip: data.rating,
    onLike: onLike,
    onTap: onTap,
    isLiked: isLiked,
    id: data.id,
  );

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
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
                      imageUrl ?? '',
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
                  if (tip != null)
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
                          tip!,
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
                        onTap: () => onLike?.call(id, text, isLiked),
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
                    text,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    descriptionText,
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
