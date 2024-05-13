import 'package:agritool/custom/custom_icon.dart';
import 'package:agritool/custom/custom_icon_button.dart';
import 'package:agritool/custom/custom_navigation.dart';
import 'package:agritool/custom/custom_text.dart';
import 'package:agritool/news/components/customListTile.dart';
import 'package:agritool/news/services/api_service.dart';
import 'package:flutter/material.dart';

import '../model/article_model.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  late ApiService client;

  @override
  void initState() {
    client = ApiService();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomIconButton(
                      onPressed: () {
                        context.pop();
                      },
                      icon: const CustomIcon(icon: Icons.arrow_back)),
                  const CustomText(text: "Popular News", fontSize: 18),
                  const Spacer()
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: FutureBuilder(
                  future: client.getArticle(),
                  builder: (BuildContext context, snapshot) {
                    if (snapshot.hasData) {
                      List<Article> articles = snapshot.data!;
                      return ListView.builder(
                        itemCount: articles.length,
                        itemBuilder: (context, index) =>
                            customListTile(articles[index], context),
                      );
                    }
                    return const Center(
                      child: CircularProgressIndicator(
                        color: Colors.blue,
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
