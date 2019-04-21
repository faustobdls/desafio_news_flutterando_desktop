import 'package:desafio_new_flutterando/models/news.dart';
import 'package:desafio_new_flutterando/services/service.dart';
import 'package:rxdart/rxdart.dart';

class NewsBloc {

  final _newService = new NewsApi();

  final _listController = BehaviorSubject<List<Articles>>.seeded(<Articles>[]);

  Observable<List<Articles>> get itemFlux => _listController.stream;
  Sink<List<Articles>> get itemEvent => _listController.sink;

  NewsBloc() {
    _newService.fetchNews().then(itemEvent.add).catchError( (errror)  => print(errror));

  }

  void dispose() {
    _listController?.close();
  }

}