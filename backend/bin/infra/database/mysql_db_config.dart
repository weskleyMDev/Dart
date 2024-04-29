import 'package:mysql1/mysql1.dart';

import '../../utils/custom_env.dart';
import 'db_config.dart';

class MySqlDBConfig implements DBConfig {
  MySqlConnection? _connection;

  @override
  Future<MySqlConnection> get connection async {
    _connection ??= await createConnection();
    if (_connection == null) {
      throw Exception("[ERROR/DB] -> Failed to create connection");
    }
    return _connection!;
  }

  @override
  Future<MySqlConnection> createConnection() async {
    final connection = await MySqlConnection.connect(
      ConnectionSettings(
        user: await CustomEnv.get<String>(key: "db_user"),
        password: await CustomEnv.get<String>(key: "db_pass"),
        db: await CustomEnv.get<String>(key: "db_name"),
      ),
    );
    return connection;
  }
}
