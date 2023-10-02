abstract class IConnectivityRepository{
  Future<bool> get hasConnection;

  Stream<bool> get connectivityStatus;
}
