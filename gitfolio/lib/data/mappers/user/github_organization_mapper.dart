import 'package:gitfolio/data/entities/github_organization_response.dart';
import 'package:gitfolio/data/mappers/base/base_mapper.dart';
import 'package:gitfolio/domain/entities/github_organization.dart';

class GithubOrganizationMapper extends BaseMapper<GithubOrganizationResponse> {
  const GithubOrganizationMapper();

  @override
  GithubOrganizationResponse fromJson(Map<String, dynamic> json) {
    return GithubOrganizationResponse(
      id: json[_Keys.id],
      login: json[_Keys.login],
      avatarUrl: json[_Keys.avatarUrl],
      description: json[_Keys.description],
    );
  }

  @override
  GithubOrganization toDomainObject(GithubOrganizationResponse response) {
    return GithubOrganization(
      id: response.id,
      login: response.login,
      avatarUrl: response.avatarUrl,
      description: response.description,
    );
  }
}

abstract class _Keys {
  static const id = 'id';
  static const login = 'login';
  static const avatarUrl = 'avatar_url';
  static const description = 'description';
}
