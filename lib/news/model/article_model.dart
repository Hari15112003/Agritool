//Now let's create the article model
// for that we just need to copy the property from the json structure
// and make a dart object

import 'source_model.dart';

class Article {
  final Source source;
  final String author;
  final String title;
  final String description;
  final String url;
  final String? urlToImage;
  final String publishedAt;
  final String content;

  //Now let's create the constructor
  Article(
      {required this.source,
      required this.author,
      required this.title,
      required this.description,
      required this.url,
      required this.urlToImage,
      required this.publishedAt,
      required this.content});

  //And now let's create the function that will map the json into a list
  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      source: Source.fromJson(json['source'] ?? {}),
      author: json['author'] as String? ?? '',
      title: json['title'] as String? ?? '',
      description: json['description'] as String? ?? '',
      url: json['url'] as String? ?? '',
      urlToImage: json['urlToImage'] as String? ??
          "https://ychef.files.bbci.co.uk/624x351/p0h0cf6t.jpg",
      publishedAt: json['publishedAt'] as String? ?? '',
      content: extractContent(json['content'] as String? ?? ''),
    );
  }
}

String extractContent(String fullContent) {
  // Find the index of "[+"
  int startIndex = fullContent.indexOf("[+");

  // If the substring is found, extract the content before it
  if (startIndex != -1) {
    return fullContent.substring(0, startIndex).trim();
  }

  // If the substring is not found, return the original content
  return fullContent.trim();
}
