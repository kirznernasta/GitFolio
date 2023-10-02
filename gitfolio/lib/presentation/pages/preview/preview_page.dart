import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gitfolio/presentation/base/base_page.dart';
import 'package:gitfolio/presentation/pages/details/details_page.dart';
import 'package:gitfolio/presentation/pages/preview/preview_cubit.dart';
import 'package:gitfolio/presentation/pages/preview/preview_state.dart';
import 'package:gitfolio/presentation/pages/widgets/error_message.dart';
import 'package:gitfolio/presentation/pages/widgets/image_list_tile.dart';
import 'package:gitfolio/presentation/pages/widgets/loading.dart';
import 'package:gitfolio/presentation/utils/constants/app_dimensions.dart';
import 'package:gitfolio/presentation/utils/constants/app_strings.dart';

class PreviewPage extends BasePage {
  const PreviewPage({super.key});

  @override
  State<BasePage> createState() => _PreviewPageState();
}

class _PreviewPageState extends BasePageState<PreviewPage, PreviewCubit> {
  late final ScrollController _controller;

  @override
  void initState() {
    super.initState();
    _controller = ScrollController()..addListener(_scrollListener);
  }

  void _scrollListener() {
    if (_controller.position.pixels == _controller.position.maxScrollExtent) {
      cubit.loadMoreUserPreviews();
    }
  }

  void _onUserTap(BuildContext context, String login) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => DetailsPage(userLogin: login),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PreviewCubit, PreviewState>(
      bloc: cubit,
      listener: (context, state) {
        if (state.hasError && state.usersPreview.isNotEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text(AppStrings.fetchingUsersError)),
          );
        }
      },
      builder: (context, state) {
        final previews = state.usersPreview;
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
          body: state.usersPreview.isEmpty && state.isLoading
              ? const Loading()
              : RefreshIndicator(
                  onRefresh: cubit.refresh,
                  child: state.hasError && state.usersPreview.isEmpty
                      ? ListView(
                          children: [ErrorMessage(message: state.errorMessage)],
                        )
                      : ListView.builder(
                          cacheExtent: MediaQuery.sizeOf(context).height,
                          physics: const AlwaysScrollableScrollPhysics(),
                          controller: _controller,
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
