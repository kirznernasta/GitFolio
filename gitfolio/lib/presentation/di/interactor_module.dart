import 'package:gitfolio/domain/interactors/details_interactor.dart';
import 'package:gitfolio/domain/interactors/preview_interactor.dart';
import 'package:gitfolio/presentation/di/injector.dart';

void initInteractorModule() {
  i
    ..registerFactory<PreviewInteractor>(
      () => PreviewInteractor(
        i.get(),
        i.get(),
      ),
    )
    ..registerFactory<DetailsInteractor>(
      () => DetailsInteractor(
        i.get(),
        i.get(),
        i.get(),
      ),
    );
}
