import 'package:flutter/material.dart';

class Avatar extends StatelessWidget {
  final String url;

  const Avatar({required this.url});

  @override
  Widget build(BuildContext context) {
    // print('AVATAR URL: "$url"');

    return ClipOval(
      child: SizedBox(
        width: 76,
        height: 76,
        child: url.trim().isNotEmpty
            ? Image.network(
                url.trim(),
                width: 76,
                height: 76,
                fit: BoxFit.cover,
                filterQuality: FilterQuality.high,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) {
                    return child;
                  }

                  return const _AvatarPlaceholder(loading: true);
                },
                errorBuilder: (context, error, stackTrace) {
                  // print('AVATAR IMAGE ERROR: $error');
                  // print('AVATAR IMAGE URL: $url');

                  return const _AvatarPlaceholder();
                },
              )
            : const _AvatarPlaceholder(),
      ),
    );
  }
}

class _AvatarPlaceholder extends StatelessWidget {
  final bool loading;

  const _AvatarPlaceholder({this.loading = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 76,
      height: 76,
      color: Colors.white.withValues(alpha: 0.08),
      child: loading
          ? const Center(
              child: SizedBox(
                width: 22,
                height: 22,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.white,
                ),
              ),
            )
          : const Icon(Icons.person_rounded, color: Colors.white, size: 38),
    );
  }
}