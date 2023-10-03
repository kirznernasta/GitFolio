import 'package:gitfolio/data/entities/github_organization_response.dart';
import 'package:gitfolio/data/mappers/base/base_mapper.dart';
import 'package:gitfolio/data/mappers/user/github_organization_mapper.dart';
import 'package:gitfolio/domain/entities/github_organization.dart';

class GithubOrganizationResponsesMapper
    extends BaseMapper<GithubOrganizationResponses> {
  const GithubOrganizationResponsesMapper();

  @override
  GithubOrganizationResponses fromJson(Map<String, dynamic> json) {
    const githubOrganizationMapper = GithubOrganizationMapper();

    final data = json[_Keys.items]
        .map(
          (json) => githubOrganizationMapper.fromJson(json),
        )
        .toList();

    return GithubOrganizationResponses(
      (data as List<dynamic>)
          .map((organization) => organization as GithubOrganizationResponse)
          .toList(),
    );
  }

  @override
  GithubOrganizationList toDomainObject(GithubOrganizationResponses response) {
    const githubOrganizationMapper = GithubOrganizationMapper();

    return GithubOrganizationList(
      response.organizations
          .map(githubOrganizationMapper.toDomainObject)
          .toList(),
    );
  }
}

abstract class _Keys {
  static const items = 'items';
}
