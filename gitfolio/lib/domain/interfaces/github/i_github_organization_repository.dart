import 'package:gitfolio/domain/entities/github_organization.dart';
import 'package:gitfolio/domain/utils/wrapper.dart';

abstract interface class IGithubOrganizationRepository {
  Stream<Wrapper<GithubOrganizationList>?> get githubOrganizationListStream;

  Future<void> getUserOrganizations(
    String userLogin,
  );
}
