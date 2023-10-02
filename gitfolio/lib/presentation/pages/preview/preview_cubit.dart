import 'package:gitfolio/domain/entities/github_user_preview.dart';
import 'package:gitfolio/domain/interactors/connectivity_interactor.dart';
import 'package:gitfolio/domain/interactors/github_user_preview_interacor.dart';
import 'package:gitfolio/presentation/base/base_cubit.dart';
import 'package:gitfolio/presentation/pages/preview/preview_state.dart';
import 'package:gitfolio/presentation/utils/constants/app_strings.dart';

class PreviewCubit extends BaseCubit<PreviewState> {
  final GithubUserPreviewInteractor _previewInteractor;
  final ConnectivityInteractor _connectivityInteractor;

  PreviewCubit(
    this._previewInteractor,
    this._connectivityInteractor,
  ) : super(const PreviewState()) {
    _loadInitialUsersPreviews();
  }

  void _loadInitialUsersPreviews({bool refresh = false}) async {
    var errorMessage = '';
    List<GithubUserPreview>? usersPreview;

    emit(state.newState(isLoading: true));

    if (await _connectivityInteractor.hasConnection) {
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

    if (await _connectivityInteractor.hasConnection) {
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
