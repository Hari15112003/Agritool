//Now let's create the article details page

import 'package:agritool/custom/custom_text.dart';
import 'package:flutter/material.dart';

import '../model/article_model.dart';

class ArticlePage extends StatelessWidget {
  final Article article;

  const ArticlePage({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(text: article.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 200.0,
              width: double.infinity,
              decoration: BoxDecoration(
                //let's add the height

                image: DecorationImage(
                    image: NetworkImage(article.urlToImage ??
                        "https://ychef.files.bbci.co.uk/624x351/p0h0cf6t.jpg"),
                    fit: BoxFit.cover),
                borderRadius: BorderRadius.circular(12.0),
              ),
            ),
            const SizedBox(
              height: 8.0,
            ),
            Container(
              padding: const EdgeInsets.all(6.0),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(30.0),
              ),
              child: CustomText(
                text: article.source.name,
                color: Colors.white,
              ),
            ),
            const SizedBox(
              height: 8.0,
            ),
            CustomText(
              text: article.description,
              fontWeight: FontWeight.bold,
              fontSize: 16.0,
            ),
            CustomText(
              text: article.content,
              fontWeight: FontWeight.bold,
              fontSize: 16.0,
            )
          ],
        ),
      ),
    );
  }
}
