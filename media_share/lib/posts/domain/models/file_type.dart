enum MediaType { image, video, unknown }

extension PathName on MediaType {
  String get pathName {
    switch (this) {
      case MediaType.image:
        return 'images';
      case MediaType.video:
        return 'videos';
      case MediaType.unknown:
        return 'images';
    }
  }
}