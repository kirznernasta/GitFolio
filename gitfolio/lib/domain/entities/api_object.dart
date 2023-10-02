import 'package:equatable/equatable.dart';

abstract class ApiObject extends Equatable {
  const ApiObject();
}

abstract class SingleListApiObject<T> extends ApiObject{
  const SingleListApiObject();

  List<T> asList();
}
