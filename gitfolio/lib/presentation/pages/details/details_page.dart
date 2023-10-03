import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gitfolio/presentation/pages/details/widgets/details_body.dart';
import 'package:gitfolio/presentation/pages/widgets/cubit_scope.dart';
import 'package:gitfolio/presentation/pages/details/cubit/details_cubit.dart';
import 'package:gitfolio/presentation/utils/constants/app_dimensions.dart';
import 'package:gitfolio/presentation/utils/constants/app_strings.dart';

class DetailsPage extends StatefulWidget {
  final String userLogin;

  const DetailsPage({required this.userLogin, super.key});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CubitScope<DetailsCubit>(
      child: BlocBuilder<DetailsCubit, DetailsState>(
        builder: (context, state) {
          final cubit = CubitScope.of<DetailsCubit>(context);

          return Scaffold(
            appBar: AppBar(
              title: Text(state.userDetails?.login ?? AppStrings.loadingTitle),
              centerTitle: true,
              backgroundColor: Theme.of(context).primaryColor,
              foregroundColor: Colors.white,
              actions: [
                if (state.userDetails?.id != null)
                  Padding(
                    padding: const EdgeInsets.only(
                      right: AppDimensions.middleMargin,
                    ),
                    child: Text(
                      '${AppStrings.id}: ${state.userDetails?.id}',
                      style: const TextStyle(
                        fontSize: AppDimensions.middleMargin,
                      ),
                    ),
                  ),
              ],
            ),
            body: DetailsBody(
              fetchUserInformation: () => cubit.fetchUserInformation(
                widget.userLogin,
              ),
            ),
          );
        },
      ),
    );
  }
}
