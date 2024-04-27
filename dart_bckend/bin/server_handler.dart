import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

class ServeHandler {
  Handler get handler {
    final router = Router();

    router.get('/home', (Request r) {
      return Response.ok('Olá Mundo!');
    });

    router.get('/home/<usuario>', (Request r, String usuario) {
      return Response.ok('Ola!!! $usuario');
    });

    //http://localhost:8080/query?nome=pedro&idade=35
    router.get('/query', (Request r) {
      String? nome = r.url.queryParameters['nome'];
      String? idade = r.url.queryParameters['idade'];
      return Response.ok('Query eh: $nome de $idade anos');
    });

    router.post('/login', (Request r) async {
      String result = await r.readAsString();
      Map json = jsonDecode(result);
      var usuario = json["user"];
      var senha = json["pass"];

      if (usuario == "admin" && senha == "123") {
        Map res = {
          'token': 'token123',
          'user_id': 1,
        };
        String jsonResponse = jsonEncode(res);
        return Response.ok(
          jsonResponse,
          headers: {
            'content-type': 'application/json',
          },
        );
      } else {
        return Response.forbidden('ERROR');
      }
    });

    return router;
  }
}
