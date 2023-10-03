import 'package:gitfolio/data/entities/api_object.dart';
import 'package:gitfolio/domain/entities/domain_object.dart';

abstract class BaseMapper<T extends ApiObject> {
  const BaseMapper();

  T fromJson(Map<String, dynamic> json);

  DomainObject toDomainObject(T response);
}
