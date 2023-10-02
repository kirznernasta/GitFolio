import 'package:gitfolio/domain/base/base_interactor.dart';
import 'package:gitfolio/domain/data_interfaces/github/i_github_organization_repository.dart';
import 'package:gitfolio/domain/entities/github_organization.dart';
import 'package:gitfolio/domain/utils/wrapper.dart';

class GithubOrganizationInteractor extends BaseInteractor {
  final IGithubOrganizationRepository _organizationRepository;

  const GithubOrganizationInteractor(this._organizationRepository);

  Future<Wrapper<GithubOrganizationList>> getUserOrganizations(
    String userLogin,
  ) {
    return _organizationRepository.getUserOrganizations(userLogin);
  }
}
