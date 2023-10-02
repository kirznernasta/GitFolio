import 'package:gitfolio/domain/base/base_interactor.dart';
import 'package:gitfolio/domain/data_interfaces/github/i_github_user_preview_repository.dart';
import 'package:gitfolio/domain/entities/github_user_preview.dart';
import 'package:gitfolio/domain/utils/wrapper.dart';

class GithubUserPreviewInteractor extends BaseInteractor {
  final IGithubUserPreviewRepository _previewRepository;

  const GithubUserPreviewInteractor(this._previewRepository);

  Future<Wrapper<GithubUserPreviewList>> getUserPreviews({
    bool refresh = false,
  }) {
    return _previewRepository.getUserPreviews(refresh: refresh);
  }
}
