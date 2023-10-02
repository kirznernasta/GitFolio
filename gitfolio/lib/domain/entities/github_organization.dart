import 'package:gitfolio/domain/entities/api_object.dart';
import 'package:gitfolio/domain/entities/extended_object.dart';

class GithubOrganization extends ExtendedObject {
  final String? description;

  const GithubOrganization({
    required super.id,
    required super.login,
    required super.avatarUrl,
    this.description,
  });

  @override
  List<Object?> get props => [
        id,
        login,
        avatarUrl,
        description,
      ];
}

class GithubOrganizationList extends SingleListApiObject<GithubOrganization> {
  final List<GithubOrganization> organizations;

  const GithubOrganizationList(this.organizations);

  @override
  List<GithubOrganization> asList() => organizations;

  @override
  List<Object?> get props => [organizations];
}
