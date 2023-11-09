import '../domain/posts_repository.dart';


class PostsRepositoryImplementation implements PostsRepository{
  //example of implementation of a function
  //just the concept. the code doesnt work
  @override
  Future<bool> ping({required String url}) async{
    //example
    // var response = await http.get(Uri.parse(url))
    // return response.statusCode == "200"? True: False;

    return true;

}


}