abstract class DBConfig {
  Future<dynamic> createConnection();
  dynamic get connection;
}
