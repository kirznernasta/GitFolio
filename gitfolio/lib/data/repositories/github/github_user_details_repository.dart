import 'package:gitfolio/data/data_source/i_remote_data_source.dart';
import 'package:gitfolio/domain/data_interfaces/github/i_github_user_details_repository.dart';
import 'package:gitfolio/domain/entities/github_user_details.dart';
import 'package:gitfolio/domain/utils/wrapper.dart';

class GithubUserDetailsRepository implements IGithubUserDetailsRepository {
  final IRemoteDataSource _remoteDataSource;

  const GithubUserDetailsRepository(this._remoteDataSource);

  @override
  Future<Wrapper<GithubUserDetails>> getUserDetails(String userLogin) {
    return _remoteDataSource.getUserDetails(userLogin);
  }
}
