import 'package:gitfolio/data/entities/github_user_preview_response.dart';
import 'package:gitfolio/data/mappers/base/base_mapper.dart';
import 'package:gitfolio/data/mappers/user/github_user_preview_mapper.dart';
import 'package:gitfolio/domain/entities/github_user_preview.dart';

class GithubUserPreviewListMapper
    extends BaseMapper<GithubUserPreviewResponses> {
  const GithubUserPreviewListMapper();

  @override
  GithubUserPreviewResponses fromJson(Map<String, dynamic> json) {
    const githubUserPreviewMapper = GithubUserPreviewMapper();

    final data = json[_Keys.items]
        .map(
          (json) => githubUserPreviewMapper.fromJson(json),
        )
        .toList();
    return GithubUserPreviewResponses(
      (data as List<dynamic>)
          .map((userPreview) => userPreview as GithubUserPreviewResponse)
          .toList(),
    );
  }

  @override
  GithubUserPreviewList toDomainObject(GithubUserPreviewResponses response) {
    const githubUserPreviewMapper = GithubUserPreviewMapper();

    return GithubUserPreviewList(
      response.users
          .map(
            githubUserPreviewMapper.toDomainObject,
          )
          .toList(),
    );
  }
}

abstract class _Keys {
  static const items = 'items';
}
