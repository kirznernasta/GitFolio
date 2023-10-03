import 'package:gitfolio/domain/client_interfaces/i_connectivity_client.dart';
import 'package:gitfolio/domain/entities/github_organization.dart';
import 'package:gitfolio/domain/entities/github_user_details.dart';
import 'package:gitfolio/domain/interfaces/github/i_github_organization_repository.dart';
import 'package:gitfolio/domain/interfaces/github/i_github_user_details_repository.dart';
import 'package:gitfolio/domain/utils/wrapper.dart';

final class DetailsInteractor {
  final IGithubUserDetailsRepository _githubUserDetailsRepository;
  final IGithubOrganizationRepository _githubOrganizationRepository;
  final IConnectivityClient _connectivityClient;

  const DetailsInteractor(
    this._githubUserDetailsRepository,
    this._githubOrganizationRepository,
    this._connectivityClient,
  );

  Future<bool> get hasInternetConnection => _connectivityClient.hasConnection;

  Stream<bool> get connectivityStatusStream =>
      _connectivityClient.connectivityStatus;

  Stream<Wrapper<GithubUserDetails>?> get githubUserDetailsStream =>
      _githubUserDetailsRepository.githubUserDetailsStream;

  Stream<Wrapper<GithubOrganizationList>?> get githubOrganizationListStream =>
      _githubOrganizationRepository.githubOrganizationListStream;

  Future<void> getUserDetails(String userLogin) async {
    return _githubUserDetailsRepository.getUserDetails(userLogin);
  }

  Future<void> getUserOrganizations(String userLogin) {
    return _githubOrganizationRepository.getUserOrganizations(userLogin);
  }

  void clearDetailsStreams() {
    _githubUserDetailsRepository.clearDetailsStreams();
  }
}
