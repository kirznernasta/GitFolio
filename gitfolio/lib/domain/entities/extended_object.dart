import 'package:gitfolio/domain/entities/domain_object.dart';

abstract class ExtendedObject extends DomainObject {
  final int id;
  final String login;
  final String avatarUrl;

  const ExtendedObject({
    required this.id,
    required this.login,
    required this.avatarUrl,
  });
}
