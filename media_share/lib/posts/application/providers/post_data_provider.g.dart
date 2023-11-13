// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_data_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$postDataHash() => r'a8c9ad21918b342abe8f29a3ebbd57a1fe2bde9d';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

abstract class _$PostData extends BuildlessAutoDisposeNotifier<Post> {
  late final String postId;

  Post build(
    String postId,
  );
}

/// See also [PostData].
@ProviderFor(PostData)
const postDataProvider = PostDataFamily();

/// See also [PostData].
class PostDataFamily extends Family<Post> {
  /// See also [PostData].
  const PostDataFamily();

  /// See also [PostData].
  PostDataProvider call(
    String postId,
  ) {
    return PostDataProvider(
      postId,
    );
  }

  @override
  PostDataProvider getProviderOverride(
    covariant PostDataProvider provider,
  ) {
    return call(
      provider.postId,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'postDataProvider';
}

/// See also [PostData].
class PostDataProvider extends AutoDisposeNotifierProviderImpl<PostData, Post> {
  /// See also [PostData].
  PostDataProvider(
    String postId,
  ) : this._internal(
          () => PostData()..postId = postId,
          from: postDataProvider,
          name: r'postDataProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$postDataHash,
          dependencies: PostDataFamily._dependencies,
          allTransitiveDependencies: PostDataFamily._allTransitiveDependencies,
          postId: postId,
        );

  PostDataProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.postId,
  }) : super.internal();

  final String postId;

  @override
  Post runNotifierBuild(
    covariant PostData notifier,
  ) {
    return notifier.build(
      postId,
    );
  }

  @override
  Override overrideWith(PostData Function() create) {
    return ProviderOverride(
      origin: this,
      override: PostDataProvider._internal(
        () => create()..postId = postId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        postId: postId,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<PostData, Post> createElement() {
    return _PostDataProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is PostDataProvider && other.postId == postId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, postId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin PostDataRef on AutoDisposeNotifierProviderRef<Post> {
  /// The parameter `postId` of this provider.
  String get postId;
}

class _PostDataProviderElement
    extends AutoDisposeNotifierProviderElement<PostData, Post>
    with PostDataRef {
  _PostDataProviderElement(super.provider);

  @override
  String get postId => (origin as PostDataProvider).postId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
