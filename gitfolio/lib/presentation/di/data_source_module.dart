import 'package:gitfolio/data/data_source/i_remote_data_source.dart';
import 'package:gitfolio/data/data_source/remote_data_source.dart';
import 'package:gitfolio/presentation/di/injector.dart';

void initDataSourceModule() {
  i.registerSingleton<IRemoteDataSource>(RemoteDataSource());
}
