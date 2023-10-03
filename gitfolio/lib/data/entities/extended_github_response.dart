import 'package:gitfolio/data/entities/api_object.dart';

abstract class ExtendedGithubResponse extends ApiObject {
  final int id;
  final String login;
  final String avatarUrl;

  const ExtendedGithubResponse({
    required this.id,
    required this.login,
    required this.avatarUrl,
  });
}
