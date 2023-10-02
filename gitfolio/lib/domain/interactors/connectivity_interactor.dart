import 'package:gitfolio/domain/base/base_interactor.dart';
import 'package:gitfolio/domain/data_interfaces/i_connectivity_repository.dart';

class ConnectivityInteractor extends BaseInteractor {
  final IConnectivityRepository _connectivityRepository;

  const ConnectivityInteractor(this._connectivityRepository);

  Future<bool> get hasConnection => _connectivityRepository.hasConnection;

  Stream<bool> get connectivityStatus =>
      _connectivityRepository.connectivityStatus;
}
