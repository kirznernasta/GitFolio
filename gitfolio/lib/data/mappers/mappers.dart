import 'package:gitfolio/data/mappers/base/remote_mapper.dart';
import 'package:gitfolio/data/mappers/user/github_organization_list_mapper.dart';
import 'package:gitfolio/data/mappers/user/github_organization_mapper.dart';
import 'package:gitfolio/data/mappers/user/github_user_details_mapper.dart';
import 'package:gitfolio/data/mappers/user/github_user_preview_list_mapper.dart';
import 'package:gitfolio/data/mappers/user/github_user_preview_mapper.dart';
import 'package:gitfolio/domain/entities/api_object.dart';

abstract class Mappers {
  static const _mappers = [
    GithubUserPreviewMapper(),
    GithubUserDetailsMapper(),
    GithubUserPreviewListMapper(),
    GithubOrganizationMapper(),
    GithubOrganizationListMapper(),
  ];

  static T fromRemoteJson<T extends ApiObject, P extends RemoteMapper<T>>(
    Map<String, dynamic> json,
  ) {
    return _getMapper<P>().fromRemoteJson(json);
  }

  static T _getMapper<T>() {
    return _mappers.firstWhere(
      (mapper) => mapper is T,
      orElse: () => throw UnimplementedError(
        'Mapper $T is not registered',
      ),
    ) as T;
  }
}
