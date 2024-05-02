class NewsModel {
  int? id;
  String? title;
  String? description;
  DateTime? dtCreated;
  DateTime? dtUpdated;
  int? userId;

  NewsModel();

  NewsModel.create(
    this.id,
    this.title,
    this.description,
    this.dtCreated,
    this.dtUpdated,
    this.userId,
  );

  factory NewsModel.fromMap(Map<String, dynamic> map) {
    return NewsModel.create(
      map['id']?.toInt(),
      map['titulo']?.toString(),
      map['descricao']?.toString(),
      map['dt_criacao'],
      map['dt_atualizacao'],
      map['id_usuario']?.toInt(),
    );
  }

  factory NewsModel.fromRequest(Map map) {
    return NewsModel()
      ..title = map['titulo']
      ..description = map['descricao']
      ..userId = map['id_usuario']?.toInt();
  }

  Map toJson() {
    return {
      "id": id,
      "titulo": title,
      "descricao": description,
    };
  }

  @override
  String toString() {
    return 'NewsModel(id: $id, title: $title, description: $description, dtCreated: $dtCreated, dtUpdated: $dtUpdated, userId: $userId)';
  }
}
