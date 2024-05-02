abstract class DBConfig {
  Future<dynamic> createConnection();
  Future<dynamic> get connection;

  Future<dynamic> execQuery(String sql);
}
