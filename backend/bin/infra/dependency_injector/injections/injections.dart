import '../../../api/blog_api.dart';
import '../../../api/login_api.dart';
import '../../../models/news_model.dart';
import '../../../services/blog_service.dart';
import '../../../services/generic_service.dart';
import '../../database/db_config.dart';
import '../../database/mysql_db_config.dart';
import '../../security/security_service.dart';
import '../../security/security_service_imp.dart';
import '../dependency_injector.dart';

class Injections {
  static DependencyInjector initializer() {
    var di = DependencyInjector();

    di.register<SecurityService>(() => SecurityServiceImp());
    di.register<LoginApi>(() => LoginApi(di.get<SecurityService>()));

    di.register<GenericService<NewsModel>>(() => BlogService());
    di.register<BlogApi>(() => BlogApi(di.get<GenericService<NewsModel>>()));

    di.register<DBConfig>(() => MySqlDBConfig());

    return di;
  }
}
