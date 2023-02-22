class UserModel {
  String username;
  String pass;
  String avatar_url;
  bool verifed;
  String status;
  String? role_user;
  int? score;

  UserModel({
    required this.username,
    required this.pass,
    required this.avatar_url,
    required this.verifed,
    required this.status,
    this.role_user,
    this.score,
  });
}
