import 'package:gitfolio/domain/entities/api_object.dart';
import 'package:gitfolio/domain/entities/extended_object.dart';

class GithubUserPreview extends ExtendedObject {

  const GithubUserPreview({
    required super.login,
    required super.id,
    required super.avatarUrl,
  });

  @override
  List<Object?> get props => [
        id,
        avatarUrl,
        login,
      ];
}

class GithubUserPreviewList extends SingleListApiObject<GithubUserPreview> {
  final List<GithubUserPreview> users;

  const GithubUserPreviewList(this.users);

  @override
  List<GithubUserPreview> asList() => users;

  @override
  List<Object?> get props => [users];
}
