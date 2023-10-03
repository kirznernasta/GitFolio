part of 'preview_cubit.dart';

class PreviewState extends Equatable {
  final bool isLoading;
  final List<GithubUserPreview> usersPreview;
  final String errorMessage;

  const PreviewState({
    this.isLoading = true,
    this.usersPreview = const [],
    this.errorMessage = '',
  });

  bool get hasError => errorMessage != '';

  PreviewState newState({
    bool? isLoading,
    List<GithubUserPreview>? usersPreview,
    String? errorMessage,
  }) {
    return PreviewState(
      isLoading: isLoading ?? this.isLoading,
      usersPreview: usersPreview ?? this.usersPreview,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        usersPreview,
        errorMessage,
      ];
}
