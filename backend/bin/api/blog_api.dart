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

    router.get('/blog/news/all', (Request request) async {
      final news = await _blogService.findAll();
      final newsJson = news.map((e) => e.toJson()).toList();
      return Response.ok(newsJson.toString());
    });

    //http://localhost:8080/blog/news?id=1
    router.get('/blog/news', (Request request) async {
      String? id = request.url.queryParameters['id'];
      if (id == null) return Response(400);
      final news = await _blogService.findOne(int.parse(id));
      return (news != null)
          ? Response.ok(jsonEncode(news.toJson()))
          : Response(404);
    });

    router.post('/blog/news', (Request request) async {
      final body = await request.readAsString();
      final result =
          await _blogService.save(NewsModel.fromRequest(jsonDecode(body)));
      return (result)
          ? Response.ok('Noticia salva com sucesso!')
          : Response(500);
    });

    router.put('/blog/news', (Request request) async {
      final body = await request.readAsString();
      final result =
          await _blogService.save(NewsModel.fromRequest(jsonDecode(body)));
      return (result)
          ? Response.ok('Noticia atualizada com sucesso!')
          : Response(500);
    });

    //http://localhost:8080/blog/news?id=1
    router.delete('/blog/news', (Request request) async {
      String? id = request.url.queryParameters['id'];
      if (id == null) return Response(400);
      final result = await _blogService.delete(int.parse(id));
      return result
          ? Response.ok('Noticia deletada com sucesso!')
          : Response.internalServerError();
    });

    return createHandler(
      router: router,
      isSecurity: isSecurity,
    );
  }
}
