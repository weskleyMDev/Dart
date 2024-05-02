import 'dart:convert';

class UserTO {
  final String email;
  final String senha;

  UserTO(this.email, this.senha);

  factory UserTO.fromRequest(String body) {
    var map = jsonDecode(body);
    return UserTO(
      map["email"],
      map["password"],
    );
  }
}
