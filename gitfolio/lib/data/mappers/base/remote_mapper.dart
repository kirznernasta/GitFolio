import 'package:gitfolio/domain/entities/api_object.dart';

abstract class RemoteMapper<T extends ApiObject> {
  const RemoteMapper();

  T fromRemoteJson(Map<String, dynamic> json);
}
