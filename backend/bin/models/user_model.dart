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
    this.isAtivo,
    this.dtCriacao,
    this.dtAtualizacao,
  );

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel.create(
      map['id']?.toInt() ?? 0,
      map['nome'] ?? '',
      map['email'] ?? '',
      map['is_ativo'] == 1,
      map['dt_criacao'],
      map['dt_atualizacao'],
    );
  }

  factory UserModel.fromEmail(Map map) {
    return UserModel()
      ..id = map["id"]
      ..email = map["email"]
      ..senha = map["senha"];
  }

  factory UserModel.fromRequest(Map map) {
    return UserModel()
      ..nome = map['nome']
      ..email = map['email']
      ..senha = map['senha'];
  }

  @override
  String toString() {
    return 'UserModel(id: $id, senha: $senha, nome: $nome, email: $email, isAtivo: $isAtivo, dtCriacao: $dtCriacao, dtAtualizacao: $dtAtualizacao)';
  }
}
