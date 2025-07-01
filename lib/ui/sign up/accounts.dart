class Accounts {
  Accounts({
    required this.user,
    required this.password,
  });

  factory Accounts.fromJson(Map<String, dynamic> map) {
    return Accounts(
      user: map['user'],
      password: map['password'],
    );
  }

  String user;
  String password;

  @override
  String toString() {
    return 'Accounts{user: $user, password: $password}';
  }


}