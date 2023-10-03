import 'package:gitfolio/domain/entities/github_user_details.dart';
import 'package:gitfolio/domain/utils/wrapper.dart';

abstract interface class IGithubUserDetailsRepository {
  Future<Wrapper<GithubUserDetails>> getUserDetails(String userLogin);
}
