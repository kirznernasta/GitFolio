import 'package:gitfolio/domain/entities/github_user_preview.dart';

class GithubUserDetails extends GithubUserPreview {
  final DateTime createdAt;
  final int followingCount;
  final int followersCount;
  final String? email;

  const GithubUserDetails({
    required this.createdAt,
    required this.followingCount,
    required this.followersCount,
    required super.login,
    required super.id,
    required super.avatarUrl,
    this.email,
  });

  @override
  List<Object?> get props => [
        id,
        login,
        avatarUrl,
        email,
        createdAt,
        followingCount,
        followersCount,
      ];
}
