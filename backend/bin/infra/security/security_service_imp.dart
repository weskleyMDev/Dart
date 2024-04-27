import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:shelf/shelf.dart';

import '../../utils/custom_env.dart';
import 'security_service.dart';
// import 'validate/api_routers.dart';

class SecurityServiceImp implements SecurityService<JWT> {
  SecurityServiceImp() {
    print('object created ${DateTime.now()}');
  }

  @override
  Future<String> generateJWT(String userID) async {
    var jwt = JWT({
      "iat": DateTime.now().millisecondsSinceEpoch,
      "userID": userID,
      "roles": ["admin", "user"]
    });
    String key = await CustomEnv.get(key: 'jwt_key');
    String token = jwt.sign(SecretKey(key));
    return token;
  }

  @override
  Future<JWT?> validateJWT(String token) async {
    String key = await CustomEnv.get(key: 'jwt_key');
    try {
      return JWT.verify(token, SecretKey(key));
    } on JWTInvalidException {
      return null;
    } on JWTExpiredException {
      return null;
    } on JWTNotActiveException {
      return null;
    } on JWTUndefinedException {
      return null;
    } catch (e) {
      return null;
    }
  }

  @override
  Middleware get authorization {
    return (Handler handler) {
      return (Request request) async {
        String? authHeader = request.headers['Authorization'];
        JWT? jwt;
        if (authHeader != null) {
          if (authHeader.startsWith("Bearer ")) {
            String token = authHeader.substring(7);
            jwt = await validateJWT(token);
          }
        }
        var req = request.change(context: {"jwt": jwt});
        return handler(req);
      };
    };
  }

  @override
  Middleware get verifyJWT => createMiddleware(
        requestHandler: (Request request) {
          // final apiSecurity = ApiRouters().add('login').add('registro');
          // if (apiSecurity.isPublic(request.url.path)) return null;
          if (request.context["jwt"] == null) {
            return Response.forbidden("Não Autorizado!");
          }
          return null;
        },
      );
}
