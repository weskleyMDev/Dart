import 'package:shelf/shelf.dart';

import 'api/blog_api.dart';
import 'api/login_api.dart';
import 'api/user_api.dart';
import 'infra/custom_server.dart';
import 'infra/dependency_injector/injections/injections.dart';
import 'infra/middleware_interception.dart';
import 'utils/custom_env.dart';

void main() async {
  CustomEnv.fromFile('.env-dev');

  final di = Injections.initializer();

  // var usuario = UserModel()
  //   ..nome = "Paulo"
  //   ..email = "paulo@gmail.com"
  //   ..senha = "456";

  // UsuarioDAO().create(usuario); // CRIA UM USUARIO
  // UsuarioDAO().update(usuario); // ATUALIZA UM USUARIO
  // UsuarioDAO().delete(usuario.id!); // DELETA UM USUARIO

  // RECUPERA O USUARIO PELO ID
  // final usuarioDAO = await UsuarioDAO().findByEmail('natalia@gmail.com');
  // final usuarioDAO = await UsuarioDAO().findOne(9);
  // print(usuarioDAO);

  // RECUPERA A LISTA DE USUARIOS
  // final usuariosDAO = await UsuarioDAO().findAll();
  // usuariosDAO.forEach(print);

  var cascadeHandler = Cascade()
      .add(di.get<LoginApi>().getHandler())
      .add(di.get<BlogApi>().getHandler(isSecurity: true))
      .add(di.get<UserApi>().getHandler(isSecurity: true))
      .handler;

  var handler = Pipeline()
      .addMiddleware(logRequests())
      .addMiddleware(MiddlewareInterception().middleware)
      .addHandler(cascadeHandler);

  await CustomServer().initialize(
    handler: handler,
    address: await CustomEnv.get<String>(key: 'server_address'),
    port: await CustomEnv.get<int>(key: 'server_port'),
  );
}
