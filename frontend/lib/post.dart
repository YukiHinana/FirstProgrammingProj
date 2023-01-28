class Post {
  String title;
  String author;
  Post(this.title, this.author);

  factory Post.fromJson(dynamic json) {
    return Post(json['title'] as String, json['author']['username'] as String);
  }

  @override
  String toString() {
    return '{ $title, $author }';
  }
}