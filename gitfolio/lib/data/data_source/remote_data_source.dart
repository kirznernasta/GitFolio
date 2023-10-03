import 'package:gitfolio/data/entities/github_organization_response.dart';
import 'package:gitfolio/data/entities/github_user_details_response.dart';
import 'package:gitfolio/data/entities/github_user_preview_response.dart';
import 'package:http/http.dart' as http;
import 'package:gitfolio/data/data_source/interfaces/i_remote_data_source.dart';
import 'package:gitfolio/data/mappers/user/github_organization_list_mapper.dart';
import 'package:gitfolio/data/mappers/user/github_user_details_mapper.dart';
import 'package:gitfolio/data/mappers/user/github_user_preview_list_mapper.dart';
import 'package:gitfolio/data/utils/response_to_wrapper.dart';
import 'package:gitfolio/domain/entities/github_organization.dart';
import 'package:gitfolio/domain/entities/github_user_details.dart';
import 'package:gitfolio/domain/entities/github_user_preview.dart';
import 'package:gitfolio/domain/utils/wrapper.dart';
import 'package:rxdart/rxdart.dart';

class RemoteDataSource implements IRemoteDataSource {
  static const _baseUrl = 'https://api.github.com/users';
  static const _organizations = '/orgs';

  static int _lastFetchedId = 0;

  final BehaviorSubject<Wrapper<GithubOrganizationList>?>
      _githubOrganizationsSubject = BehaviorSubject.seeded(null);

  final BehaviorSubject<Wrapper<GithubUserDetails>?> _githubUserDetailsSubject =
      BehaviorSubject.seeded(null);

  final BehaviorSubject<Wrapper<GithubUserPreviewList>?>
      _githubUserPreviewsSubject = BehaviorSubject.seeded(null);

  bool get _githubUserPreviewsHasValue =>
      _githubUserPreviewsSubject.value != null &&
      _githubUserPreviewsSubject.hasValue;

  @override
  Stream<Wrapper<GithubUserDetails>?> get githubUserDetailsStream =>
      _githubUserDetailsSubject;

  @override
  Stream<Wrapper<GithubOrganizationList>?> get githubUserOrganizationStream =>
      _githubOrganizationsSubject;

  @override
  Stream<Wrapper<GithubUserPreviewList>?> get githubUserPreviewsStream =>
      _githubUserPreviewsSubject;

  @override
  Future<void> getUserDetails(String userLogin) async {
    final response = await http.get(Uri.parse('$_baseUrl/$userLogin'));

    _githubUserDetailsSubject.add(
      response.toWrapper<GithubUserDetails, GithubUserDetailsResponse,
          GithubUserDetailsMapper>(),
    );
  }

  @override
  Future<void> getUsersList({
    bool refresh = false,
  }) async {
    if (refresh) {
      _lastFetchedId = 0;
    }
    final url = Uri.parse(_baseUrl).replace(
      queryParameters: {_QueryParameters.minId: _lastFetchedId.toString()},
    );
    final response = await http.get(url);

    if (_githubUserPreviewsHasValue && !refresh) {
      final previousWrapper = _githubUserPreviewsSubject.value!;

      final responseWrapper = response.toWrapper<GithubUserPreviewList,
          GithubUserPreviewResponses, GithubUserPreviewListMapper>(
        isList: true,
      );

      final newWrapper = Wrapper(
        data: GithubUserPreviewList(
          [...previousWrapper.data!.users, ...responseWrapper.data!.users],
        ),
      );

      _githubUserPreviewsSubject.add(newWrapper);
      _lastFetchedId = responseWrapper.data!.users.last.id;
    } else {
      _githubUserPreviewsSubject.add(
        response.toWrapper<GithubUserPreviewList, GithubUserPreviewResponses,
            GithubUserPreviewListMapper>(
          isList: true,
        ),
      );
      _lastFetchedId = 46;
    }
  }

  @override
  Future<void> getUserOrganization(
    String userLogin,
  ) async {
    final response =
        await http.get(Uri.parse('$_baseUrl/$userLogin$_organizations'));

    _githubOrganizationsSubject.add(
      response.toWrapper<GithubOrganizationList, GithubOrganizationResponses,
          GithubOrganizationResponsesMapper>(
        isList: true,
      ),
    );
  }

  @override
  void clearDetailsSubjects() {
    _githubUserDetailsSubject.add(null);
    _githubOrganizationsSubject.add(null);
  }
}

abstract class _QueryParameters {
  static const minId = 'since';
}
