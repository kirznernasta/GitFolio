import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gitfolio/presentation/pages/details/details_page.dart';
import 'package:gitfolio/presentation/pages/preview/cubit/preview_cubit.dart';
import 'package:gitfolio/presentation/pages/widgets/error_message.dart';
import 'package:gitfolio/presentation/pages/widgets/image_list_tile.dart';
import 'package:gitfolio/presentation/pages/widgets/loading.dart';
import 'package:gitfolio/presentation/utils/constants/app_dimensions.dart';
import 'package:gitfolio/presentation/utils/constants/app_strings.dart';

final class PreviewBody extends StatefulWidget {
  final AsyncCallback onRefresh;
  final VoidCallback loadMoreUserPreviews;

  const PreviewBody({
    required this.onRefresh,
    required this.loadMoreUserPreviews,
    super.key,
  });

  @override
  State<PreviewBody> createState() => _PreviewBodyState();
}

class _PreviewBodyState extends State<PreviewBody> {
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();

    _scrollController = ScrollController()..addListener(_scrollListener);
  }

  void _onUserTap(BuildContext context, String login) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => DetailsPage(userLogin: login),
      ),
    );
  }

  void _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      widget.loadMoreUserPreviews();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PreviewCubit, PreviewState>(
      builder: (context, state) {
        final previews = state.usersPreview;

        return state.usersPreview.isEmpty && state.isLoading
            ? const Loading()
            : RefreshIndicator(
                onRefresh: widget.onRefresh,
                child: state.hasError && state.usersPreview.isEmpty
                    ? ListView(
                        children: [
                          ErrorMessage(message: state.errorMessage),
                        ],
                      )
                    : ListView.builder(
                        cacheExtent: MediaQuery.sizeOf(context).height,
                        physics: const AlwaysScrollableScrollPhysics(),
                        controller: _scrollController,
                        itemCount: previews.length + 1,
                        itemBuilder: (context, index) {
                          if (index == previews.length) {
                            return _LastItem(isLoading: state.isLoading);
                          }
                          return ImageListTile(
                            imageUrl: state.usersPreview[index].avatarUrl,
                            title: state.usersPreview[index].login,
                            subtitle: '${AppStrings.id}: '
                                '${state.usersPreview[index].id}',
                            isItalicSubtitle: false,
                            onTap: () => _onUserTap(
                              context,
                              state.usersPreview[index].login,
                            ),
                            tileColor: index.isEven
                                ? Theme.of(context).highlightColor
                                : Theme.of(context).cardColor,
                          );
                        },
                      ),
              );
      },
    );
  }
}

class _LastItem extends StatelessWidget {
  final bool isLoading;

  const _LastItem({required this.isLoading});

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return SizedBox(
        height: AppDimensions.biggestSize,
        child: Center(
          child: CircularProgressIndicator(
            color: Theme.of(context).primaryColor,
          ),
        ),
      );
    }
    return const SizedBox.shrink();
  }
}
