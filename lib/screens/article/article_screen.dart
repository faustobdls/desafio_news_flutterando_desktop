import 'package:desafio_new_flutterando/models/news.dart';
import 'package:flutter/material.dart';

class ArticleScreen extends StatelessWidget {

  final Articles article;

  const ArticleScreen({Key key, this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(article.title),
        centerTitle: true,
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Hero(
              tag: article.urlToImage,
              child: Container(
                width: double.infinity,
                height: 200,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(article.urlToImage),
                    fit: BoxFit.cover
                  )
                ),
              )),
              Text(article.content)
          ],
        ),
      )
    );
  }
}