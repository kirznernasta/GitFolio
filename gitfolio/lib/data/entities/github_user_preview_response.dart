import 'package:gitfolio/data/entities/api_object.dart';
import 'package:gitfolio/data/entities/extended_github_response.dart';

final class GithubUserPreviewResponse extends ExtendedGithubResponse {
  const GithubUserPreviewResponse({
    required super.login,
    required super.id,
    required super.avatarUrl,
  });
}

final class GithubUserPreviewResponses extends SingleListApiObject {
  final List<GithubUserPreviewResponse> users;

  const GithubUserPreviewResponses(this.users);

  @override
  List<GithubUserPreviewResponse> asList() => users;
}
