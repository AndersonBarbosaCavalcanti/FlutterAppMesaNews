
class NoticiaModel {
  String title;
  String description;
  String content;
  String author;
  String publishedAt;
  bool highlight;
  String url;
  String imageUrl;

  NoticiaModel({
    this.title,
    this.description,
    this.content,
    this.author,
    this.publishedAt,
    this.highlight,
    this.url,
    this.imageUrl,
  });

  NoticiaModel.fromJsonMap(Map<String, dynamic> json) {

    title         = json['title'];
    description   = json['description'];
    content       = json['content'];
    author        = json['author'];
    publishedAt   = json['published_at'];
    highlight     = json['highlight'];
    url           = json['url'];
    imageUrl      = json['image_url'];
  }
}
