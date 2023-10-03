import 'package:gitfolio/domain/entities/github_user_preview.dart';
import 'package:gitfolio/domain/utils/wrapper.dart';

abstract interface class IGithubUserPreviewRepository {
  Stream<Wrapper<GithubUserPreviewList>?> get githubUserPreviewListStream;

  Future<void> getUserPreviews({
    bool refresh = false,
  });
}
