import '../dao/news_dao.dart';
import '../models/news_model.dart';
import 'generic_service.dart';

class BlogService implements GenericService<NewsModel> {
  final NewsDAO _newsDAO;
  BlogService(this._newsDAO);

  @override
  Future<bool> delete(int id) async {
    return _newsDAO.delete(id);
  }

  @override
  Future<List<NewsModel>> findAll() async {
    return _newsDAO.findAll();
  }

  @override
  Future<NewsModel?> findOne(int id) async {
    return _newsDAO.findOne(id);
  }

  @override
  Future<bool> save(NewsModel value) async {
    if (value.id != null) {
      return _newsDAO.update(value);
    } else {
      return _newsDAO.create(value);
    }
  }
}
