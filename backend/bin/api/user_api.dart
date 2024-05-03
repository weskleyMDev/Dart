import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import '../models/user_model.dart';
import '../services/user_service.dart';
import 'api.dart';

class UserApi extends Api {
  final UserService _userService;
  UserApi(this._userService);

  @override
  Handler getHandler({
    bool isSecurity = false,
  }) {
    final router = Router();

    router.get('/users', (Request request) async {
      final users = await _userService.findAll();
      final usersJson = users.map((e) => e.toJson()).toList();
      return Response.ok(usersJson.toString());
    });

    router.get('/user', (Request request) async {
      final id = request.url.queryParameters['id'];
      if (id == null) return Response(400);
      final user = await _userService.findOne(int.parse(id));
      return (user != null)
          ? Response.ok(jsonEncode(user.toJson()))
          : Response(404);
    });

    router.post('/user', (Request request) async {
      final body = await request.readAsString();
      if (body.isEmpty) return Response(400);
      final user = UserModel.fromRequest(jsonDecode(body));
      final result = await _userService.save(user);
      return ((result)
          ? Response.ok('Usuario salvo com sucesso!')
          : Response(500));
    });

    router.put('/user', (Request request) async {
      final body = await request.readAsString();
      final result =
          await _userService.save(UserModel.fromRequest(jsonDecode(body)));
      return (result)
          ? Response.ok('Usuario atualizado com sucesso!')
          : Response(500);
    });

    router.delete('/user', (Request request) async {
      final id = request.url.queryParameters['id'];
      if (id == null) return Response(400);
      final result = await _userService.delete(int.parse(id));
      return result
          ? Response.ok('Usuario deletado com sucesso!')
          : Response.internalServerError();
    });

    return createHandler(
      router: router,
      isSecurity: isSecurity,
    );
  }
}
