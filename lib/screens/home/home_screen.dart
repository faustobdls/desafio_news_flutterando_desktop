import 'package:desafio_new_flutterando/models/news.dart';
import 'package:desafio_new_flutterando/screens/article/article_screen.dart';
import 'package:flutter/material.dart';
import 'package:desafio_new_flutterando/bloc/news_bloc.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  NewsBloc _newsBloc;

  @override
  void initState() {
    _newsBloc = NewsBloc();
    super.initState();
  }

  @override
  void dispose() {
    _newsBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bloc do Rully Puro'),
        centerTitle: true,
      ),
      body: StreamBuilder<List<Articles>>(
        stream: _newsBloc.itemFlux,
        initialData: [],
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (!snapshot?.hasData)
            return Center(
              child: CircularProgressIndicator(),
            );
          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (BuildContext context, int index) {
              final Articles articles = snapshot.data[index];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  leading: Hero(
                      tag: articles.urlToImage,
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(articles.urlToImage),
                      )),
                  title: Text(articles.author),
                  subtitle: Text(articles.content),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (BuildContext context) => ArticleScreen(article: articles,)
                    ));
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
