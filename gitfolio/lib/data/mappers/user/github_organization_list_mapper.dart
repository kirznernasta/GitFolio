import 'package:gitfolio/data/mappers/base/remote_mapper.dart';
import 'package:gitfolio/data/mappers/mappers.dart';
import 'package:gitfolio/data/mappers/user/github_organization_mapper.dart';
import 'package:gitfolio/domain/entities/github_organization.dart';

class GithubOrganizationListMapper
    extends RemoteMapper<GithubOrganizationList> {
  const GithubOrganizationListMapper();

  @override
  GithubOrganizationList fromRemoteJson(Map<String, dynamic> json) {
    final data = json[_Keys.items]
        .map(
          (json) => Mappers.fromRemoteJson<GithubOrganization,
              GithubOrganizationMapper>(
            json,
          ),
        )
        .toList();
    return GithubOrganizationList(
      (data as List<dynamic>)
          .map((organization) => organization as GithubOrganization)
          .toList(),
    );
  }
}

abstract class _Keys {
  static const items = 'items';
}
