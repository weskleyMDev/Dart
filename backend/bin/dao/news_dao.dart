import '../infra/database/db_config.dart';
import '../models/news_model.dart';
import 'dao.dart';

class NewsDAO implements DAO<NewsModel> {
  final DBConfig _dbConfig;
  NewsDAO(this._dbConfig);

  @override
  Future<bool> create(NewsModel value) async {
    final res = await _dbConfig.execQuery(
        "INSERT INTO dart.noticias (titulo, descricao, id_usuario) VALUES ('${value.title}', '${value.description}', ${value.userId});");
    return res.affectedRows != 0;
  }

  @override
  Future<bool> delete(int id) async {
    final res = await _dbConfig.execQuery("DELETE FROM dart.noticias WHERE id = $id;");
    return res.affectedRows != 0;
  }

  @override
  Future<List<NewsModel>> findAll() async {
    final res = await _dbConfig.execQuery("SELECT * FROM dart.noticias;");
    return res
        .map((e) => NewsModel.fromMap(e.fields))
        .toList()
        .cast<NewsModel>();
  }

  @override
  Future<NewsModel?> findOne(int id) async {
    final res = await _dbConfig.execQuery("SELECT * FROM dart.noticias WHERE id = $id;");
    final news = NewsModel.fromMap(res.first.fields);
    return (res.affectedRows == 0) ? null : news;
  }

  @override
  Future<bool> update(NewsModel value) async {
    final res = await _dbConfig.execQuery(
        "UPDATE dart.noticias SET titulo = '${value.title}', descricao = '${value.description}' WHERE id = ${value.id};");
    return res.affectedRows != 0;
  }

}
