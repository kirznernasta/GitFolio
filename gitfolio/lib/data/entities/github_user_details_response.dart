import 'package:gitfolio/data/entities/extended_github_response.dart';

final class GithubUserDetailsResponse extends ExtendedGithubResponse {
  final String createdAt;
  final int followingCount;
  final int followersCount;
  final String? email;

  const GithubUserDetailsResponse({
    required this.createdAt,
    required this.followingCount,
    required this.followersCount,
    required super.login,
    required super.id,
    required super.avatarUrl,
    this.email,
  });
}