import 'package:gitfolio/data/mappers/base/remote_mapper.dart';
import 'package:gitfolio/domain/entities/github_organization.dart';

class GithubOrganizationMapper extends RemoteMapper<GithubOrganization> {
  const GithubOrganizationMapper();

  @override
  GithubOrganization fromRemoteJson(Map<String, dynamic> json) {
    return GithubOrganization(
      id: json[_Keys.id],
      login: json[_Keys.login],
      avatarUrl: json[_Keys.avatarUrl],
      description: json[_Keys.description],
    );
  }
}

abstract class _Keys {
  static const id = 'id';
  static const login = 'login';
  static const avatarUrl = 'avatar_url';
  static const description = 'description';
}
