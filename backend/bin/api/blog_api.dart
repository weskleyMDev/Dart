import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import '../models/news_model.dart';
import '../services/generic_service.dart';
import 'api.dart';

class BlogApi extends Api {
  final GenericService<NewsModel> _service;
  BlogApi(this._service);

  @override
  Handler getHandler({
    bool isSecurity = false,
  }) {
    Router router = Router();

    //READ
    router.get('/blog/news', (Request resquest) async {
      final news = await _service.findAll();
      final newsJson = news.map((e) => e.toJson()).toList();
      return Response.ok(newsJson.toString());
    });

    //CREATE
    router.post('/blog/news', (Request request) async {
      var body = await request.readAsString();
      _service.save(NewsModel.fromJson(body));
      return Response.ok('BLOG NEWS POST');
    });

    //UPDATE
    //http://localhost:8080/blog/news?id=1
    router.put('/blog/news', (Request request) {
      // String? id = request.url.queryParameters['id'];
      // _service.save();
      return Response.ok('BLOG NEWS PUT');
    });

    //DELETE
    //http://localhost:8080/blog/news?id=1
    router.delete('/blog/news', (Request request) {
      String? id = request.url.queryParameters['id'];
      _service.delete(int.parse(id!));
      return Response.ok('BLOG NEWS DELETE');
    });

    return createHandler(
      router: router,
      isSecurity: isSecurity,
    );
  }
}
