import 'package:gitfolio/domain/client_interfaces/i_connectivity_client.dart';
import 'package:gitfolio/domain/entities/github_user_preview.dart';
import 'package:gitfolio/domain/interfaces/github/i_github_user_preview_repository.dart';
import 'package:gitfolio/domain/utils/wrapper.dart';

final class PreviewInteractor {
  final IGithubUserPreviewRepository _githubUserPreviewRepository;
  final IConnectivityClient _connectivityClient;

  const PreviewInteractor(
    this._githubUserPreviewRepository,
    this._connectivityClient,
  );

  Future<bool> get hasInternetConnection => _connectivityClient.hasConnection;

  Stream<bool> get connectivityStatusStream =>
      _connectivityClient.connectivityStatus;

  Future<Wrapper<GithubUserPreviewList>> getUserPreviews({
    bool refresh = false,
  }) {
    return _githubUserPreviewRepository.getUserPreviews(refresh: refresh);
  }
}
