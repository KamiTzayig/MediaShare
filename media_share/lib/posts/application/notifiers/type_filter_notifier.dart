
import 'package:media_share/posts/domain/models/file_type.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'type_filter_notifier.g.dart';
@riverpod
class TypeFilterNotifier extends _$TypeFilterNotifier {
  @override
   MediaType build() {
    return MediaType.unknown;
  }

  void filter(MediaType type) {
    state = type;
  }
}
