class Usuario {
  String _nome = '';
  String _email = '';
  String _password = '';
  String _telefone = '';

  Usuario();

  String get nome => _nome;
  set nome(String nome) => _nome = nome;
  String get email => _email;
  set email(String email) => _email = email;
  String get password => _password;
  set password(String password) => _password = password;
  String get telefone => _telefone;
  set telefone(String telefone) => _telefone = telefone;
}
