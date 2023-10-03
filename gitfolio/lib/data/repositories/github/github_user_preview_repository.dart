import 'package:gitfolio/data/data_source/interfaces/i_remote_data_source.dart';
import 'package:gitfolio/domain/interfaces/github/i_github_user_preview_repository.dart';
import 'package:gitfolio/domain/entities/github_user_preview.dart';
import 'package:gitfolio/domain/utils/wrapper.dart';

class GithubUserPreviewRepository implements IGithubUserPreviewRepository {
  final IRemoteDataSource _remoteDataSource;

  const GithubUserPreviewRepository(this._remoteDataSource);

  @override
  Stream<Wrapper<GithubUserPreviewList>?> get githubUserPreviewListStream =>
      _remoteDataSource.githubUserPreviewsStream;

  @override
  Future<void> getUserPreviews({
    bool refresh = false,
  }) {
    return _remoteDataSource.getUsersList(refresh: refresh);
  }
}
