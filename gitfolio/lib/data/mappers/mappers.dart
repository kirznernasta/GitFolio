import 'package:gitfolio/data/entities/api_object.dart';
import 'package:gitfolio/data/mappers/base/base_mapper.dart';
import 'package:gitfolio/data/mappers/user/github_organization_list_mapper.dart';
import 'package:gitfolio/data/mappers/user/github_organization_mapper.dart';
import 'package:gitfolio/data/mappers/user/github_user_details_mapper.dart';
import 'package:gitfolio/data/mappers/user/github_user_preview_list_mapper.dart';
import 'package:gitfolio/data/mappers/user/github_user_preview_mapper.dart';
import 'package:gitfolio/domain/entities/domain_object.dart';

abstract class Mappers {
  static const _mappers = [
    GithubUserPreviewMapper(),
    GithubUserDetailsMapper(),
    GithubUserPreviewListMapper(),
    GithubOrganizationMapper(),
    GithubOrganizationResponsesMapper(),
  ];

  static T fromRemoteJson<T extends DomainObject, M extends ApiObject,
      P extends BaseMapper<M>>(
    Map<String, dynamic> json,
  ) {
    final mapper = _getMapper<P>();

    final responseFromJson = mapper.fromJson(json);

    return mapper.toDomainObject(responseFromJson) as T;
  }

  static T _getMapper<T extends BaseMapper>() {
    return _mappers.firstWhere(
      (mapper) => mapper is T,
      orElse: () => throw UnimplementedError(
        'Mapper $T is not registered',
      ),
    ) as T;
  }
}
