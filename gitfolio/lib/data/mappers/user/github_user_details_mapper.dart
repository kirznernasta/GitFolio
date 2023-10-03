import 'package:gitfolio/data/entities/github_user_details_response.dart';
import 'package:gitfolio/data/mappers/base/base_mapper.dart';
import 'package:gitfolio/domain/entities/github_user_details.dart';

class GithubUserDetailsMapper extends BaseMapper<GithubUserDetailsResponse> {
  const GithubUserDetailsMapper();

  @override
  GithubUserDetailsResponse fromJson(Map<String, dynamic> json) {
    return GithubUserDetailsResponse(
      email: json[_Keys.email],
      createdAt: json[_Keys.createdAt],
      followingCount: json[_Keys.followingCount],
      followersCount: json[_Keys.followersCount],
      login: json[_Keys.login],
      id: json[_Keys.id],
      avatarUrl: json[_Keys.avatarUrl],
    );
  }

  @override
  GithubUserDetails toDomainObject(GithubUserDetailsResponse response) {
    return GithubUserDetails(
      createdAt: DateTime.parse(response.createdAt),
      followingCount: response.followingCount,
      followersCount: response.followersCount,
      login: response.login,
      id: response.id,
      avatarUrl: response.avatarUrl,
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
