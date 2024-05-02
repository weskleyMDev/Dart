import '../../../api/blog_api.dart';
import '../../../api/login_api.dart';
import '../../../api/user_api.dart';
import '../../../dao/usuario_dao.dart';
import '../../../models/news_model.dart';
import '../../../services/blog_service.dart';
import '../../../services/generic_service.dart';
import '../../../services/login_service.dart';
import '../../../services/user_service.dart';
import '../../database/db_config.dart';
import '../../database/mysql_db_config.dart';
import '../../security/security_service.dart';
import '../../security/security_service_imp.dart';
import '../dependency_injector.dart';

class Injections {
  static DependencyInjector initializer() {
    var di = DependencyInjector();

    di.register<GenericService<NewsModel>>(() => BlogService());
    di.register<BlogApi>(() => BlogApi(di.get<GenericService<NewsModel>>()));

    di.register<DBConfig>(() => MySqlDBConfig());

    di.register<UsuarioDAO>(() => UsuarioDAO(di.get<DBConfig>()));
    di.register<UserService>(() => UserService(di.get<UsuarioDAO>()));
    di.register<UserApi>(() => UserApi(di.get<UserService>()));

    di.register<SecurityService>(() => SecurityServiceImp());
    di.register<LoginService>(() => LoginService(di.get<UserService>()));
    di.register<LoginApi>(
        () => LoginApi(di.get<SecurityService>(), di.get<LoginService>()));

    return di;
  }
}
