import '../notifiers/posts_state_notifier.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';


final postsStateProvider = StateNotifierProvider((ref) {
return PostsStateNotifier();
});

