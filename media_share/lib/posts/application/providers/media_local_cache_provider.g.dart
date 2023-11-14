// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'media_local_cache_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$mediaLocalCacheHash() => r'3d86af7c2a88198e418d8eff782708d78e2b8561';

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

abstract class _$MediaLocalCache
    extends BuildlessAutoDisposeAsyncNotifier<Uint8List?> {
  late final String url;

  FutureOr<Uint8List?> build(
    String url,
  );
}

/// See also [MediaLocalCache].
@ProviderFor(MediaLocalCache)
const mediaLocalCacheProvider = MediaLocalCacheFamily();

/// See also [MediaLocalCache].
class MediaLocalCacheFamily extends Family<AsyncValue<Uint8List?>> {
  /// See also [MediaLocalCache].
  const MediaLocalCacheFamily();

  /// See also [MediaLocalCache].
  MediaLocalCacheProvider call(
    String url,
  ) {
    return MediaLocalCacheProvider(
      url,
    );
  }

  @override
  MediaLocalCacheProvider getProviderOverride(
    covariant MediaLocalCacheProvider provider,
  ) {
    return call(
      provider.url,
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
  String? get name => r'mediaLocalCacheProvider';
}

/// See also [MediaLocalCache].
class MediaLocalCacheProvider
    extends AutoDisposeAsyncNotifierProviderImpl<MediaLocalCache, Uint8List?> {
  /// See also [MediaLocalCache].
  MediaLocalCacheProvider(
    String url,
  ) : this._internal(
          () => MediaLocalCache()..url = url,
          from: mediaLocalCacheProvider,
          name: r'mediaLocalCacheProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$mediaLocalCacheHash,
          dependencies: MediaLocalCacheFamily._dependencies,
          allTransitiveDependencies:
              MediaLocalCacheFamily._allTransitiveDependencies,
          url: url,
        );

  MediaLocalCacheProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.url,
  }) : super.internal();

  final String url;

  @override
  FutureOr<Uint8List?> runNotifierBuild(
    covariant MediaLocalCache notifier,
  ) {
    return notifier.build(
      url,
    );
  }

  @override
  Override overrideWith(MediaLocalCache Function() create) {
    return ProviderOverride(
      origin: this,
      override: MediaLocalCacheProvider._internal(
        () => create()..url = url,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        url: url,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<MediaLocalCache, Uint8List?>
      createElement() {
    return _MediaLocalCacheProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is MediaLocalCacheProvider && other.url == url;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, url.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin MediaLocalCacheRef on AutoDisposeAsyncNotifierProviderRef<Uint8List?> {
  /// The parameter `url` of this provider.
  String get url;
}

class _MediaLocalCacheProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<MediaLocalCache, Uint8List?>
    with MediaLocalCacheRef {
  _MediaLocalCacheProviderElement(super.provider);

  @override
  String get url => (origin as MediaLocalCacheProvider).url;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
