import 'package:gitfolio/data/utils/response_statuses.dart';

class Wrapper<T> {
  final T? data;
  final int status;

  const Wrapper({this.data, this.status = ResponseStatuses.ok});

  bool get isSuccess =>
      status >= ResponseStatuses.ok && status < ResponseStatuses.badRequest;
}
