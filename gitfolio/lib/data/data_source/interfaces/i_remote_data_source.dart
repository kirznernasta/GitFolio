import 'package:gitfolio/domain/entities/github_user_preview.dart';
import 'package:gitfolio/domain/entities/github_organization.dart';
import 'package:gitfolio/domain/entities/github_user_details.dart';
import 'package:gitfolio/domain/utils/wrapper.dart';

abstract interface class IRemoteDataSource {
  Future<Wrapper<GithubUserPreviewList>> getUsersList({bool refresh = false});

  Future<Wrapper<GithubUserDetails>> getUserDetails(String userLogin);

  Future<Wrapper<GithubOrganizationList>> getUserOrganization(String userLogin);
}
