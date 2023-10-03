import 'package:gitfolio/data/entities/api_object.dart';
import 'package:gitfolio/data/entities/extended_github_response.dart';

final class GithubOrganizationResponse extends ExtendedGithubResponse {
  final String? description;

  const GithubOrganizationResponse({
    required super.id,
    required super.login,
    required super.avatarUrl,
    this.description,
  });
}

final class GithubOrganizationResponses extends SingleListApiObject {
  final List<GithubOrganizationResponse> organizations;

  const GithubOrganizationResponses(this.organizations);

  @override
  List<GithubOrganizationResponse> asList() => organizations;
}
