import 'package:gitfolio/presentation/di/injector.dart';
import 'package:gitfolio/presentation/pages/details/details_cubit.dart';
import 'package:gitfolio/presentation/pages/preview/preview_cubit.dart';

void initCubitModule() {
  i.registerFactory<PreviewCubit>(() => PreviewCubit(i.get(), i.get()));
  i.registerFactory<DetailsCubit>(
    () => DetailsCubit(
      i.get(),
      i.get(),
      i.get(),
    ),
  );
}
