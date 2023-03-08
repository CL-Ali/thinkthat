class Post {
  String id;
  String imageUrl;
  String title;
  String prompt;

  Post({
    this.id = "",
    this.imageUrl = "",
    this.title = "",
    this.prompt = "",
  });
  static List<Post> convertIntoList(List response) {
    List<Post> tList = [];
    Post post;
    response.forEach((element) {
      post = Post()
        ..id = element['id'].toString()
        ..prompt = element['prompt'].toString()
        ..imageUrl = element['photo']
        ..title = element['name'].toString();
      tList.add(post);
    });
    return tList;
  }

  static List<Post> searchList(String match,
      {List<Post> posts = const [], bool isPostTap = false}) {
    List<Post> tList = [];
    if (posts.isNotEmpty) {
      posts.forEach((element) {
        if (isPostTap) {
          if (element.title.toLowerCase() != match.toLowerCase() &&
              element.title
                  .toLowerCase()
                  .contains(match.substring(0, 1).toLowerCase())) {
            tList.add(element);
          }
        } else {
          if (element.title.toLowerCase().contains(match)) {
            tList.add(element);
          }
        }
      });
    }
    return tList;
  }
}
