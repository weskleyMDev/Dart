import '../models/news_model.dart';
import '../utils/list_extension.dart';
import 'generic_service.dart';

class BlogService implements GenericService<NewsModel> {
  final List<NewsModel> _fakeDB = [];

  @override
  Future<bool> delete(int id) async {
    _fakeDB.removeWhere((element) => element.id == id);
    return true;
  }

  @override
  Future<List<NewsModel>> findAll() async {
    return _fakeDB;
  }

  @override
  Future<NewsModel> findOne(int id) async {
    return _fakeDB.firstWhere((element) => element.id == id);
  }

  @override
  Future<bool> save(NewsModel value) async {
    NewsModel? model =
        _fakeDB.firstWhereOrNull((element) => element.id == value.id);
    if (model == null) {
      _fakeDB.add(value);
    } else {
      int index = _fakeDB.indexOf(model);
      _fakeDB[index] = value;
    }
    return true;
  }
}
