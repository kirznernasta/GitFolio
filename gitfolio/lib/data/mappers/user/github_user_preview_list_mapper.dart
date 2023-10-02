import 'package:gitfolio/data/mappers/base/remote_mapper.dart';
import 'package:gitfolio/data/mappers/mappers.dart';
import 'package:gitfolio/data/mappers/user/github_user_preview_mapper.dart';
import 'package:gitfolio/domain/entities/github_user_preview.dart';

class GithubUserPreviewListMapper extends RemoteMapper<GithubUserPreviewList> {
  const GithubUserPreviewListMapper();

  @override
  GithubUserPreviewList fromRemoteJson(Map<String, dynamic> json) {
    final data = json[_Keys.items]
        .map(
          (json) => Mappers.fromRemoteJson<GithubUserPreview,
              GithubUserPreviewMapper>(
            json,
          ),
        )
        .toList();
    return GithubUserPreviewList(
      (data as List<dynamic>)
          .map((userPreview) => userPreview as GithubUserPreview)
          .toList(),
    );
  }
}

abstract class _Keys{
  static const items = 'items';
}
