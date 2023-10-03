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

class RemoteDataSource implements IRemoteDataSource {
  static const _baseUrl = 'https://api.github.com/users';
  static const _organizations = '/orgs';

  static int _lastFetchedId = 0;

  @override
  Future<Wrapper<GithubUserDetails>> getUserDetails(String userLogin) async {
    final response = await http.get(Uri.parse('$_baseUrl/$userLogin'));

    return response.toWrapper<GithubUserDetails, GithubUserDetailsResponse,
        GithubUserDetailsMapper>();
  }

  @override
  Future<Wrapper<GithubUserPreviewList>> getUsersList({
    bool refresh = false,
  }) async {
    if (refresh) {
      _lastFetchedId = 0;
    }
    final url = Uri.parse(_baseUrl).replace(
      queryParameters: {_QueryParameters.minId: _lastFetchedId.toString()},
    );
    final response = await http.get(url);
    _lastFetchedId += 30;
    return response.toWrapper<GithubUserPreviewList, GithubUserPreviewResponses,
        GithubUserPreviewListMapper>(
      isList: true,
    );
  }

  @override
  Future<Wrapper<GithubOrganizationList>> getUserOrganization(
    String userLogin,
  ) async {
    final response =
        await http.get(Uri.parse('$_baseUrl/$userLogin$_organizations'));
    return response.toWrapper<GithubOrganizationList,
        GithubOrganizationResponses, GithubOrganizationResponsesMapper>(
      isList: true,
    );
  }
}

abstract class _QueryParameters {
  static const minId = 'since';
}
