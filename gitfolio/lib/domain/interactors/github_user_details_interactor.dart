import 'package:gitfolio/domain/base/base_interactor.dart';
import 'package:gitfolio/domain/data_interfaces/github/i_github_user_details_repository.dart';
import 'package:gitfolio/domain/entities/github_user_details.dart';
import 'package:gitfolio/domain/utils/wrapper.dart';

class GithubUserDetailsInteractor extends BaseInteractor {
  final IGithubUserDetailsRepository _detailsRepository;

  const GithubUserDetailsInteractor(this._detailsRepository);

  Future<Wrapper<GithubUserDetails>> getUserDetails(String userLogin) async{
    return _detailsRepository.getUserDetails(userLogin);
  }
}
