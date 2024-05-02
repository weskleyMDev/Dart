class UserModel {
  int? id;
  String? nome;
  String? email;
  String? senha;
  bool? isAtivo;
  DateTime? dtCriacao;
  DateTime? dtAtualizacao;

  UserModel();

  UserModel.create(
    this.id,
    this.nome,
    this.email,
    this.senha,
    this.isAtivo,
    this.dtCriacao,
    this.dtAtualizacao,
  );

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel.create(
      map['id']?.toInt() ?? 0,
      map['nome'] ?? '',
      map['email'] ?? '',
      map['password'] ?? '',
      map['is_ativo'] == 1,
      map['dt_criacao'],
      map['dt_atualizacao'],
    );
  }

  factory UserModel.fromEmail(Map map) {
    return UserModel()
      ..id = map["id"] ?? 0
      ..email = map["email"] ?? ''
      ..senha = map["password"] ?? '';
  }

  factory UserModel.fromRequest(Map map) {
    return UserModel()
      ..nome = map['nome']
      ..email = map['email']
      ..senha = map['password'];
  }

  @override
  String toString() {
    return 'UserModel(id: $id, snome: $nome, email: $email, isAtivo: $isAtivo, dtCriacao: $dtCriacao, dtAtualizacao: $dtAtualizacao)';
  }
}
