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
      map['id'] as int,
      map['nome'] as String,
      map['email'] as String,
      map['is_ativo'] == 1,
      map['dt_criacao'],
      map['dt_atualizacao'],
    );
  }

  @override
  String toString() {
    return 'UserModel(id: $id, nome: $nome, email: $email, isAtivo: $isAtivo, dtCriacao: $dtCriacao, dtAtualizacao: $dtAtualizacao)';
  }
}
