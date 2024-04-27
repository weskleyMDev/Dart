import 'package:shelf/shelf.dart';

abstract class Api {
  Handler getHandler({List<Middleware>? middleware});
  Handler createHandler({
    required Handler router,
    List<Middleware>? middleware,
  }) {
    middleware ??= [];
    var pipeline = Pipeline();
    for (var e in middleware) {
      pipeline = pipeline.addMiddleware(e);
    }
    return pipeline.addHandler(router);
  }
}
