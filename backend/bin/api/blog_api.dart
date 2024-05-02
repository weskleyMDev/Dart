import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import '../models/news_model.dart';
import '../services/blog_service.dart';
import 'api.dart';

class BlogApi extends Api {
  final BlogService _blogService;
  BlogApi(this._blogService);

  @override
  Handler getHandler({
    bool isSecurity = false,
  }) {
    final router = Router();

    //READ
    router.get('/blog/news', (Request resquest) async {
      final news = await _blogService.findAll();
      final newsJson = news.map((e) => e.toJson()).toList();
      return Response.ok(newsJson.toString());
    });

    //CREATE
    router.post('/blog/news', (Request request) async {
      final body = await request.readAsString();
      final result = await _blogService.save(NewsModel.fromRequest(jsonDecode(body)));
      return (result) ? Response(201) : Response(500);
    });

    //UPDATE
    //http://localhost:8080/blog/news?id=1
    router.put('/blog/news', (Request request) {
      // String? id = request.url.queryParameters['id'];
      // _blogService.save();
      return Response.ok('BLOG NEWS PUT');
    });

    //DELETE
    //http://localhost:8080/blog/news?id=1
    router.delete('/blog/news', (Request request) {
      String? id = request.url.queryParameters['id'];
      _blogService.delete(int.parse(id!));
      return Response.ok('BLOG NEWS DELETE');
    });

    return createHandler(
      router: router,
      isSecurity: isSecurity,
    );
  }
}
