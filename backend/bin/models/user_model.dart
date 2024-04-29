class UserModel {
  final int id;
  final String nome;
  final String email;
  final bool isAtivo;
  final DateTime dtCriacao;
  final DateTime dtAtualizacao;

  UserModel({
    required this.id,
    required this.nome,
    required this.email,
    required this.isAtivo,
    required this.dtCriacao,
    required this.dtAtualizacao,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] as int,
      nome: map['nome'] as String,
      email: map['email'] as String,
      isAtivo: map['is_ativo'] == 1,
      dtCriacao: map['dt_criacao'],
      dtAtualizacao: map['dt_atualizacao'],
    );
  }

  @override
  String toString() {
    return 'UserModel(id: $id, nome: $nome, email: $email, isAtivo: $isAtivo, dtCriacao: $dtCriacao, dtAtualizacao: $dtAtualizacao)';
  }
}
