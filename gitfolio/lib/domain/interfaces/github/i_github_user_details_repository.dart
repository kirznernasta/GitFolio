import 'package:gitfolio/domain/entities/github_user_details.dart';
import 'package:gitfolio/domain/utils/wrapper.dart';

abstract interface class IGithubUserDetailsRepository {
  Stream<Wrapper<GithubUserDetails>?> get githubUserDetailsStream;

  Future<void> getUserDetails(String userLogin);

  void clearDetailsStreams();
}
