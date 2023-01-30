class Post {
  String title;
  String author;
  String body;
  Post(this.title, this.author, this.body);

  factory Post.fromJson(dynamic json) {
    return Post(json['title'] as String, json['author']['username'] as String, json['body'] as String);
  }

  @override
  String toString() {
    return '{ $title, $author, $body }';
  }
}