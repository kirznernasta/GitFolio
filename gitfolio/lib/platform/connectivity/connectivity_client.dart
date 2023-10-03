import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:gitfolio/domain/client_interfaces/i_connectivity_client.dart';

class ConnectivityClient implements IConnectivityClient {
  final _connectionChecker = InternetConnectionChecker.createInstance();

  @override
  Future<bool> get hasConnection => _connectionChecker.hasConnection;

  @override
  Stream<bool> get connectivityStatus => _connectionChecker.onStatusChange
      .map((status) => status == InternetConnectionStatus.connected);
}
