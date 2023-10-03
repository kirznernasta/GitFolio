import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gitfolio/domain/entities/github_user_preview.dart';
import 'package:gitfolio/domain/interactors/preview_interactor.dart';
import 'package:gitfolio/presentation/utils/constants/app_strings.dart';

part 'preview_state.dart';

class PreviewCubit extends Cubit<PreviewState> {
  final PreviewInteractor _previewInteractor;

  PreviewCubit(
    this._previewInteractor,
  ) : super(
          const PreviewState(),
        ) {
    _loadInitialUsersPreviews();
  }

  void _loadInitialUsersPreviews({bool refresh = false}) async {
    var errorMessage = '';
    List<GithubUserPreview>? usersPreview;

    emit(state.newState(isLoading: true));

    if (await _previewInteractor.hasInternetConnection) {
      final initialUsersPreviewWrapper =
          await _previewInteractor.getUserPreviews(refresh: refresh);
      if (initialUsersPreviewWrapper.isSuccess) {
        usersPreview = initialUsersPreviewWrapper.data?.asList();
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

  Future<void> refresh() async {
    return _loadInitialUsersPreviews(refresh: true);
  }

  void loadMoreUserPreviews() async {
    var errorMessage = '';
    List<GithubUserPreview>? usersPreview;

    emit(state.newState(isLoading: true));

    if (await _previewInteractor.hasInternetConnection) {
      final usersPreviewWrapper = await _previewInteractor.getUserPreviews();
      if (usersPreviewWrapper.isSuccess) {
        usersPreview = [
          ...state.usersPreview,
          ...?usersPreviewWrapper.data?.users,
        ];
      } else {
        errorMessage = AppStrings.error;
      }
    } else {
      errorMessage = AppStrings.connectionError;
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
