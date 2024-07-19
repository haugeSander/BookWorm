import 'package:isar/isar.dart';

part 'user.g.dart';

@Collection()
class User {
  Id userId = Isar.autoIncrement;
  String? username;
  String? firstName;
  String? lastName;
  String? biography;
  String? profileImage;

  User(
      {this.username,
      this.firstName,
      this.lastName,
      this.biography,
      this.profileImage});
}
