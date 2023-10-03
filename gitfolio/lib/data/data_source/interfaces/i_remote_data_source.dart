import 'package:gitfolio/domain/entities/github_user_preview.dart';
import 'package:gitfolio/domain/entities/github_organization.dart';
import 'package:gitfolio/domain/entities/github_user_details.dart';
import 'package:gitfolio/domain/utils/wrapper.dart';

abstract interface class IRemoteDataSource {
  Stream<Wrapper<GithubUserPreviewList>?> get githubUserPreviewsStream;

  Stream<Wrapper<GithubUserDetails>?> get githubUserDetailsStream;

  Stream<Wrapper<GithubOrganizationList>?> get githubUserOrganizationStream;

  Future<void> getUsersList({bool refresh = false});

  Future<void> getUserDetails(String userLogin);

  Future<void> getUserOrganization(String userLogin);

  void clearDetailsSubjects();
}
