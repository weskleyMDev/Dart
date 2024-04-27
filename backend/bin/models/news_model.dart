import 'dart:convert';

class NewsModel {
  final int id;
  final String titulo;
  final String texto;
  final String image;
  final DateTime dataAtual;
  final DateTime? novaData;

  NewsModel({
    required this.id,
    required this.titulo,
    required this.texto,
    required this.image,
    required this.dataAtual,
    required this.novaData,
  });

  @override
  String toString() {
    return 'NewsModel(id: $id, titulo: $titulo, texto: $texto, image: $image, dataAtual: $dataAtual, novaData: $novaData)';
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'titulo': titulo,
      'texto': texto,
      'image': image,
      'dataAtual': dataAtual.millisecondsSinceEpoch,
      'novaData': novaData?.millisecondsSinceEpoch,
    };
  }

  factory NewsModel.fromMap(Map<String, dynamic> map) {
    return NewsModel(
      id: map['id'] as int,
      titulo: map['titulo'] as String,
      texto: map['texto'] as String,
      image: map['image'] as String,
      dataAtual: DateTime.fromMillisecondsSinceEpoch(map['dataAtual'] as int),
      novaData: map['novaData'] != null ? DateTime.fromMillisecondsSinceEpoch(map['novaData'] as int) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory NewsModel.fromJson(String source) => NewsModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
