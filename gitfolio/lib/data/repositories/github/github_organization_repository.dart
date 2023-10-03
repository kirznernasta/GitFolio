import 'package:gitfolio/data/data_source/interfaces/i_remote_data_source.dart';
import 'package:gitfolio/domain/interfaces/github/i_github_organization_repository.dart';
import 'package:gitfolio/domain/entities/github_organization.dart';
import 'package:gitfolio/domain/utils/wrapper.dart';

class GithubOrganizationRepository implements IGithubOrganizationRepository {
  final IRemoteDataSource _remoteDataSource;

  const GithubOrganizationRepository(this._remoteDataSource);

  @override
  Stream<Wrapper<GithubOrganizationList>?> get githubOrganizationListStream =>
      _remoteDataSource.githubUserOrganizationStream;

  @override
  Future<void> getUserOrganizations(String userLogin) {
    return _remoteDataSource.getUserOrganization(userLogin);
  }
}
