import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gitfolio/domain/entities/github_user_preview.dart';
import 'package:gitfolio/domain/interactors/preview_interactor.dart';
import 'package:gitfolio/domain/utils/wrapper.dart';
import 'package:gitfolio/presentation/utils/constants/app_strings.dart';

part 'preview_state.dart';

class PreviewCubit extends Cubit<PreviewState> {
  final PreviewInteractor _previewInteractor;

  PreviewCubit(
    this._previewInteractor,
  ) : super(
          const PreviewState(),
        ) {
    _init();
  }

  StreamSubscription<Wrapper<GithubUserPreviewList>?>?
      _githubUserPreviewListSubscription;

  @override
  Future<void> close() {
    _githubUserPreviewListSubscription?.cancel();
    _githubUserPreviewListSubscription = null;

    return super.close();
  }

  Future<void> refresh() async {
    await _loadUserPreviews(refresh: true);
  }

  Future<void> loadMoreUserPreviews() async {
    emit(
      state.newState(isLoading: true),
    );
    await _loadUserPreviews();
  }

  void _init() {
    _loadUserPreviews();
    _subscribeAll();
  }

  Future<void> _loadUserPreviews({bool refresh = false}) async {
    refresh
        ? await _previewInteractor.getUserPreviews(refresh: true)
        : _previewInteractor.getUserPreviews(refresh: refresh);
  }

  void _subscribeAll() {
    _githubUserPreviewListSubscription =
        _previewInteractor.githubUserPreviewListStream.listen(
      _onNewPreviewList,
    );
  }

  void _onNewPreviewList(Wrapper<GithubUserPreviewList>? wrapper) {
    if (wrapper != null) {
      _handleDataFromWrapper(userPreviewsWrapper: wrapper);
    }
  }

  Future<void> _handleDataFromWrapper({
    required Wrapper<GithubUserPreviewList> userPreviewsWrapper,
  }) async {
    var errorMessage = '';
    List<GithubUserPreview>? usersPreview;

    emit(
      state.newState(isLoading: true),
    );

    if (await _previewInteractor.hasInternetConnection) {
      if (userPreviewsWrapper.isSuccess) {
        usersPreview = userPreviewsWrapper.data?.asList();
      } else {
        errorMessage = AppStrings.error;
      }
    } else {
      errorMessage =
          '${AppStrings.connectionError}. ${AppStrings.pullToRefresh}';
    }
    emit(
      state.newState(
        usersPreview: usersPreview,
        isLoading: false,
        errorMessage: errorMessage,
      ),
    );
  }
}
