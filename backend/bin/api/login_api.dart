import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import '../infra/security/security_service.dart';
import '../services/login_service.dart';
import '../to/user_to.dart';
import 'api.dart';

class LoginApi extends Api {
  final SecurityService _securityService;
  final LoginService _loginService;
  LoginApi(this._securityService, this._loginService);

  @override
  Handler getHandler({
    bool isSecurity = false,
    // List<Middleware>? middleware,
  }) {
    final router = Router();

    router.post('/login', (Request request) async {
      final body = await request.readAsString();
      final userTO = UserTO.fromRequest(body);
      final userID = await _loginService.auth(userTO);
      if (userID > 0) {
        final jwt = await _securityService.generateJWT(userID.toString());
        return Response.ok(jsonEncode({"token": jwt}));
      } else {
        print(userID);
        return Response(401);
      }
    });

    return createHandler(
      router: router,
      isSecurity: isSecurity,
      // middleware: middleware,
    );
  }
}
