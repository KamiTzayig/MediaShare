import 'package:auth_feature/auth_feature.dart';
import 'package:flutter/material.dart';
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
                hint: Text("Filter"),
                items: [
        DropdownMenuItem(
        child: Text("All"),
    value: MediaType.unknown,
    ),
          DropdownMenuItem(
            child: Icon(Icons.image),
            value: MediaType.image,
          ),
              DropdownMenuItem(
                child: Icon(Icons.video_library_outlined),
                value: MediaType.video,
              )
        ], onChanged: (MediaType? type) {
          if (type != null) {
            ref.read(typeFilterNotifierProvider.notifier).filter(type);
          }
        })),
        Expanded(
          child: PostsGrid(),
        ),
      ],
    );
  }
}
