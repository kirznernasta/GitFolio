import 'dart:convert';

import 'package:gitfolio/data/entities/api_object.dart';
import 'package:gitfolio/data/mappers/mappers.dart';
import 'package:gitfolio/domain/entities/domain_object.dart';
import 'package:http/http.dart';
import 'package:gitfolio/data/mappers/base/base_mapper.dart';
import 'package:gitfolio/data/utils/response_statuses.dart';
import 'package:gitfolio/domain/utils/wrapper.dart';

extension ResponseToWrapper on Response {
  bool get isSuccessful {
    return statusCode >= ResponseStatuses.ok &&
        statusCode <= ResponseStatuses.noContent;
  }

  Wrapper<T> toWrapper<T extends DomainObject, M extends ApiObject,
      P extends BaseMapper<M>>({
    bool isList = false,
  }) {
    if (isSuccessful) {
      return Wrapper<T>(
        data: Mappers.fromRemoteJson<T, M, P>(
          jsonDecode(isList ? '{"items": $body}' : body),
        ),
        status: statusCode,
      );
    }
    return Wrapper<T>(status: statusCode);
  }
}
