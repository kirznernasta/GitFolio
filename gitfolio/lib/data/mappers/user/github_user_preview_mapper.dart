import 'package:gitfolio/data/mappers/base/remote_mapper.dart';
import 'package:gitfolio/domain/entities/github_user_preview.dart';

class GithubUserPreviewMapper extends RemoteMapper<GithubUserPreview> {
  const GithubUserPreviewMapper();

  @override
  GithubUserPreview fromRemoteJson(Map<String, dynamic> json) {
    return GithubUserPreview(
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
}
