//example of an abstract repository which the data layer will implement
abstract class PostsRepository {
  Future<bool> ping({required String url});
}
