import 'package:shelf/shelf.dart';

import 'api/blog_api.dart';
import 'api/login_api.dart';
import 'dao/usuario_dao.dart';
import 'infra/custom_server.dart';
import 'infra/dependency_injector/injections/injections.dart';
import 'infra/middleware_interception.dart';
import 'models/user_model.dart';
import 'utils/custom_env.dart';

void main() async {
  CustomEnv.fromFile('.env-dev');

  final di = Injections.initializer();

  // var conexao = await di.get<DBConfig>().connection;

  // AJUSTA DADOS DO USUARIO
  final usuario = UserModel()
    ..nome = "Maria"
    ..email = "maria@gmail.com"
    ..senha = "456123"
    ..id = 4;

  // UsuarioDAO().create(usuario); // CRIA UM USUARIO
  // UsuarioDAO().update(usuario); // ATUALIZA UM USUARIO
  // UsuarioDAO().delete(usuario.id!); // DELETA UM USUARIO

  // RECUPERA O USUARIO PELO ID
  // final usuarioDAO = await UsuarioDAO().findOne(4);
  // print(usuarioDAO);

  // RECUPERA A LISTA DE USUARIOS
  final usuariosDAO = await UsuarioDAO().findAll();
  usuariosDAO.forEach(print);

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
