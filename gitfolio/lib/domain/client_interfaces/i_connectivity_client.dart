abstract interface class IConnectivityClient{
  Future<bool> get hasConnection;

  Stream<bool> get connectivityStatus;
}
