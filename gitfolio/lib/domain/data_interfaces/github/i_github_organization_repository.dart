import 'package:gitfolio/domain/entities/github_organization.dart';
import 'package:gitfolio/domain/utils/wrapper.dart';

abstract class IGithubOrganizationRepository {
  Future<Wrapper<GithubOrganizationList>> getUserOrganizations(
    String userLogin,
  );
}
