import 'package:gitfolio/presentation/di/injector.dart';
import 'package:gitfolio/presentation/pages/details/cubit/details_cubit.dart';
import 'package:gitfolio/presentation/pages/preview/cubit/preview_cubit.dart';

void initCubitModule() {
  i
    ..registerFactory<PreviewCubit>(
      () => PreviewCubit(
        i.get(),
      ),
    )
    ..registerFactory<DetailsCubit>(
      () => DetailsCubit(
        i.get(),
      ),
    );
}
