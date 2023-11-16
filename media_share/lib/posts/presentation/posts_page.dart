import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:media_share/posts/application/notifiers/type_filter_notifier.dart';
import 'package:media_share/posts/domain/models/file_type.dart';
import './widgets/posts_grid.dart';

class PostsView extends ConsumerWidget {
  /// {@macro posts_view}
  const PostsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
            trailing: DropdownButton(
                hint: const Text("Filter"),
                items: const [
                  DropdownMenuItem(
                    value: MediaType.unknown,
                    child: Text("All"),
                  ),
                  DropdownMenuItem(
                    value: MediaType.image,
                    child: Icon(Icons.image),
                  ),
                  DropdownMenuItem(
                    value: MediaType.video,
                    child: Icon(Icons.video_library_outlined),
                  )
                ],
                onChanged: (MediaType? type) {
                  if (type != null) {
                    ref.read(typeFilterNotifierProvider.notifier).filter(type);
                  }
                })),
        const Expanded(
          child: PostsGrid(),
        ),
      ],
    );
  }
}
