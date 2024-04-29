import 'package:shelf/shelf.dart';
import 'package:mysql1/mysql1.dart';

import 'api/blog_api.dart';
import 'api/login_api.dart';
import 'infra/custom_server.dart';
import 'infra/dependency_injector/injections/injections.dart';
import 'infra/middleware_interception.dart';
import 'utils/custom_env.dart';

void main() async {
  CustomEnv.fromFile('.env-dev');

  var conexao = await MySqlConnection.connect(
    ConnectionSettings(
      user: await CustomEnv.get<String>(key: "db_user"),
      password: await CustomEnv.get<String>(key: "db_pass"),
      db: await CustomEnv.get<String>(key: "db_name"),
    ),
  );

  var resultado = await conexao.query("SELECT * FROM dart.usuarios;");
  print(resultado);

  final di = Injections.initializer();

  // di.register<SecurityService>(() => SecurityServiceImp());
  // final securityService = di.get<SecurityService>();

  var cascadeHandler = Cascade()
      .add(di.get<LoginApi>().getHandler())
      .add(di.get<BlogApi>().getHandler(isSecurity: true))
      .handler;

  var handler = Pipeline()
      .addMiddleware(logRequests())
      .addMiddleware(MiddlewareInterception().middleware)
      // .addMiddleware(securityService.authorization)
      // .addMiddleware(securityService.verifyJWT)
      .addHandler(cascadeHandler);

  await CustomServer().initialize(
    handler: handler,
    address: await CustomEnv.get<String>(key: 'server_address'),
    port: await CustomEnv.get<int>(key: 'server_port'),
  );
}
