import 'dart:convert';

import 'package:http/http.dart';
import 'package:gitfolio/data/mappers/base/remote_mapper.dart';
import 'package:gitfolio/data/mappers/mappers.dart';
import 'package:gitfolio/data/utils/response_statuses.dart';
import 'package:gitfolio/domain/entities/api_object.dart';
import 'package:gitfolio/domain/utils/wrapper.dart';

extension ResponseToWrapper on Response {
  bool get isSuccessful {
    return statusCode >= ResponseStatuses.ok &&
        statusCode <= ResponseStatuses.noContent;
  }

  Wrapper<T> toWrapper<T extends ApiObject, P extends RemoteMapper<T>>({
    bool isList = false,
  }) {
    if (isSuccessful) {
      return Wrapper<T>(
        data: Mappers.fromRemoteJson<T, P>(
          jsonDecode(isList ? '{"items": $body}' : body),
        ),
        status: statusCode,
      );
    }
    return Wrapper<T>(status: statusCode);
  }
}
