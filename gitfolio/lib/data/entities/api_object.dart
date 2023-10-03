abstract class ApiObject {
  const ApiObject();
}

abstract class SingleListApiObject<T> extends ApiObject{
  const SingleListApiObject();

  List<T> asList();
}