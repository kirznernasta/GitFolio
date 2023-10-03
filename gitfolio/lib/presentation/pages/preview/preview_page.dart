import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gitfolio/presentation/pages/preview/cubit/preview_cubit.dart';
import 'package:gitfolio/presentation/pages/preview/widgets/preview_body.dart';
import 'package:gitfolio/presentation/pages/widgets/cubit_scope.dart';
import 'package:gitfolio/presentation/utils/constants/app_strings.dart';

class PreviewPage extends StatelessWidget {
  const PreviewPage({super.key});

  void _previewListener(BuildContext context, PreviewState state) {
    if (state.hasError && state.usersPreview.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text(AppStrings.fetchingUsersError)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return CubitScope<PreviewCubit>(
      child: BlocConsumer<PreviewCubit, PreviewState>(
        listener: _previewListener,
        builder: (context, state) {
          final cubit = CubitScope.of<PreviewCubit>(context);
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Theme.of(context).primaryColor,
              title: Text(
                state.hasError && state.usersPreview.isEmpty
                    ? AppStrings.oops
                    : AppStrings.users,
              ),
              foregroundColor: Theme.of(context).canvasColor,
              centerTitle: true,
            ),
            body: PreviewBody(
              onRefresh: cubit.refresh,
              loadMoreUserPreviews: cubit.loadMoreUserPreviews,
            ),
          );
        },
      ),
    );
  }
}
