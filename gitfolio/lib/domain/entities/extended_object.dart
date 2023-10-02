import 'package:gitfolio/domain/entities/api_object.dart';

abstract class ExtendedObject extends ApiObject {
  final int id;
  final String login;
  final String avatarUrl;

  const ExtendedObject({
    required this.id,
    required this.login,
    required this.avatarUrl,
  });
}
