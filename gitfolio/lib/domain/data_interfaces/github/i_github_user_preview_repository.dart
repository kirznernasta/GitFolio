import 'package:gitfolio/domain/entities/github_user_preview.dart';
import 'package:gitfolio/domain/utils/wrapper.dart';

abstract class IGithubUserPreviewRepository {
  Future<Wrapper<GithubUserPreviewList>> getUserPreviews({
    bool refresh = false,
  });
}
