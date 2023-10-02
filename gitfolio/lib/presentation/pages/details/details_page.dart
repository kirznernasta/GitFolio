import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:gitfolio/domain/entities/github_organization.dart';
import 'package:gitfolio/presentation/base/base_page.dart';
import 'package:gitfolio/presentation/pages/details/details_cubit.dart';
import 'package:gitfolio/presentation/pages/details/details_state.dart';
import 'package:gitfolio/presentation/pages/widgets/error_message.dart';
import 'package:gitfolio/presentation/pages/widgets/image_list_tile.dart';
import 'package:gitfolio/presentation/pages/widgets/loading.dart';
import 'package:gitfolio/presentation/utils/constants/app_dimensions.dart';
import 'package:gitfolio/presentation/utils/constants/app_fonts.dart';
import 'package:gitfolio/presentation/utils/constants/app_strings.dart';

part 'package:gitfolio/presentation/pages/details/widgets.dart';

class DetailsPage extends BasePage {
  final String userLogin;

  const DetailsPage({required this.userLogin, super.key});

  @override
  State<BasePage> createState() => _DetailsPageState();
}

class _DetailsPageState extends BasePageState<DetailsPage, DetailsCubit> {
  @override
  void initState() {
    super.initState();
    cubit.initWithData(widget.userLogin);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DetailsCubit, DetailsState>(
      bloc: cubit,
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(state.userDetails?.login ?? AppStrings.loadingTitle),
            centerTitle: true,
            backgroundColor: Theme.of(context).primaryColor,
            foregroundColor: Colors.white,
            actions: [
              if (state.userDetails?.id != null)
                Padding(
                  padding:
                      const EdgeInsets.only(right: AppDimensions.middleMargin),
                  child: Text(
                    '${AppStrings.id}: ${state.userDetails?.id}',
                    style:
                        const TextStyle(fontSize: AppDimensions.middleMargin),
                  ),
                ),
            ],
          ),
          body: !state.isLoading
              ? state.hasError
                  ? ErrorMessage(message: state.errorMessage)
                  : Padding(
                      padding: const EdgeInsets.all(AppDimensions.bigMargin),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _UserImage(url: state.userDetails!.avatarUrl),
                          const SizedBox(height: AppDimensions.bigMargin),
                          _TextInformation(
                            name: AppStrings.email,
                            value: state.userDetails?.email,
                          ),
                          const SizedBox(height: AppDimensions.smallMargin),
                          _TextInformation(
                            name: AppStrings.followers,
                            value: state.userDetails!.followersCount.toString(),
                          ),
                          const SizedBox(height: AppDimensions.smallMargin),
                          _TextInformation(
                            name: AppStrings.followings,
                            value: state.userDetails!.followingCount.toString(),
                          ),
                          const SizedBox(height: AppDimensions.smallMargin),
                          _TextInformation(
                            name: AppStrings.createdAt,
                            value: DateFormat.yMMMMd()
                                .format(state.userDetails!.createdAt),
                          ),
                          const Spacer(),
                          if (state.userOrganizations.isNotEmpty)
                            FilledButton(
                              onPressed: () {
                                showModalBottomSheet(
                                  context: context,
                                  builder: (context) {
                                    return _Organizations(
                                      organizations: state.userOrganizations,
                                    );
                                  },
                                );
                              },
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(AppStrings.viewOrganizations),
                                ],
                              ),
                            ),
                        ],
                      ),
                    )
              : const Loading(),
        );
      },
    );
  }
}
