import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gitfolio/domain/entities/github_organization.dart';
import 'package:gitfolio/presentation/pages/details/cubit/details_cubit.dart';
import 'package:gitfolio/presentation/pages/widgets/error_message.dart';
import 'package:gitfolio/presentation/pages/widgets/image_list_tile.dart';
import 'package:gitfolio/presentation/pages/widgets/loading.dart';
import 'package:gitfolio/presentation/utils/constants/app_dimensions.dart';
import 'package:gitfolio/presentation/utils/constants/app_fonts.dart';
import 'package:gitfolio/presentation/utils/constants/app_strings.dart';
import 'package:intl/intl.dart';

part 'package:gitfolio/presentation/pages/details/widgets/user_widgets.dart';

final class DetailsBody extends StatefulWidget {
  final VoidCallback initUserWithData;

  const DetailsBody({
    required this.initUserWithData,
    super.key,
  });

  @override
  State<DetailsBody> createState() => _DetailsBodyState();
}

class _DetailsBodyState extends State<DetailsBody> {
  @override
  void initState() {
    super.initState();

    widget.initUserWithData();
  }

  Future<void> _onOrganizationTap(
    BuildContext context,
    List<GithubOrganization> userOrganizations,
  ) {
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return _Organizations(
          organizations: userOrganizations,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DetailsCubit, DetailsState>(
      builder: (context, state) {
        return !state.isLoading
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
                            onPressed: () => _onOrganizationTap(
                              context,
                              state.userOrganizations,
                            ),
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
            : const Loading();
      },
    );
  }
}
