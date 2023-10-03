import 'package:gitfolio/data/entities/github_user_preview_response.dart';
import 'package:gitfolio/data/mappers/base/base_mapper.dart';
import 'package:gitfolio/domain/entities/github_user_preview.dart';

class GithubUserPreviewMapper extends BaseMapper<GithubUserPreviewResponse> {
  const GithubUserPreviewMapper();

  @override
  GithubUserPreviewResponse fromJson(Map<String, dynamic> json) {
    return GithubUserPreviewResponse(
      login: json[_Keys.login],
      id: json[_Keys.id],
      avatarUrl: json[_Keys.avatarUrl],
    );
  }

  @override
  GithubUserPreview toDomainObject(GithubUserPreviewResponse response) {
    return GithubUserPreview(
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
}
