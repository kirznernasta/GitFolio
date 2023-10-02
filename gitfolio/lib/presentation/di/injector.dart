import 'package:get_it/get_it.dart';
import 'package:gitfolio/presentation/di/cubit_module.dart';
import 'package:gitfolio/presentation/di/data_source_module.dart';
import 'package:gitfolio/presentation/di/interactor_module.dart';
import 'package:gitfolio/presentation/di/page_module.dart';
import 'package:gitfolio/presentation/di/repository_module.dart';

GetIt get i => GetIt.instance;

void initInjector() {
  initDataSourceModule();
  initRepositoryModule();
  initInteractorModule();
  initCubitModule();
  initPageModule();
}
