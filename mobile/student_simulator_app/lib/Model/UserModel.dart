class UserModel {
  String username;
  String pass;
  String avatar_url;
  String? description;
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
    this.description,
    this.role_user,
    this.score,
  });
}
