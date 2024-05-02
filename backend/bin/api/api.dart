import 'package:shelf/shelf.dart';

import '../infra/dependency_injector/dependency_injector.dart';
import '../infra/security/security_service.dart';

abstract class Api {
  Handler getHandler({
    bool isSecurity = false,
  });

  Handler createHandler({
    required Handler router,
    required bool isSecurity,
    List<Middleware>? middleware,
  }) {
    middleware ??= [];

    if (isSecurity) {
      final service = DependencyInjector().get<SecurityService>();
      middleware.addAll([
        service.authorization,
        service.verifyJWT,
      ]);
    }

    var pipeline = Pipeline();
    for (var e in middleware) {
      pipeline = pipeline.addMiddleware(e);
    }
    return pipeline.addHandler(router);
  }
}
