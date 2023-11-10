enum FileType { image, video }

extension PathName on FileType {
  String get pathName {
    switch (this) {
      case FileType.image:
        return 'images';
      case FileType.video:
        return 'videos';
    }
  }
}