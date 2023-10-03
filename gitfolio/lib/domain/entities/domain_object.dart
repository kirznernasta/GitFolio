import 'package:equatable/equatable.dart';

abstract class DomainObject extends Equatable {
  const DomainObject();
}

abstract class SingleListDomainObject<T> extends DomainObject{
  const SingleListDomainObject();

  List<T> asList();
}
