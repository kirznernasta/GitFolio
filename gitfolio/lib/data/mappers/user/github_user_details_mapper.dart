import 'package:gitfolio/data/mappers/base/remote_mapper.dart';
import 'package:gitfolio/domain/entities/github_user_details.dart';

class GithubUserDetailsMapper extends RemoteMapper<GithubUserDetails> {
  const GithubUserDetailsMapper();

  @override
  GithubUserDetails fromRemoteJson(Map<String, dynamic> json) {
    return GithubUserDetails(
      email: json[_Keys.email],
      createdAt: DateTime.parse(json[_Keys.createdAt]),
      followingCount: json[_Keys.followingCount],
      followersCount: json[_Keys.followersCount],
      login: json[_Keys.login],
      id: json[_Keys.id],
      avatarUrl: json[_Keys.avatarUrl],
    );
  }
}

abstract class _Keys {
  static const id = 'id';
  static const login = 'login';
  static const avatarUrl = 'avatar_url';
  static const email = 'email';
  static const createdAt = 'created_at';
  static const followingCount = 'following';
  static const followersCount = 'followers';
}
