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
    // List<Middleware>? middleware,
  }) {
    final router = Router();

    router.post('/user', (Request request) async {
      final body = await request.readAsString();
      if (body.isEmpty) return Response(400);
      final user = UserModel.fromRequest(jsonDecode(body));
      final result = await _userService.save(user);
      return ((result) ? Response(201) : Response(500));
    });

    return createHandler(
      router: router,
      isSecurity: isSecurity,
    );
  }
}
