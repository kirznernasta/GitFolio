part of 'details_cubit.dart';

class DetailsState extends Equatable {
  final String? userLogin;
  final GithubUserDetails? userDetails;
  final List<GithubOrganization>? userOrganizations;
  final String errorMessage;
  final bool isLoading;

  const DetailsState({
    this.userLogin,
    this.userDetails,
    this.userOrganizations,
    this.isLoading = true,
    this.errorMessage = '',
  });

  bool get hasError => errorMessage != '';

  DetailsState newState({
    String? userLogin,
    GithubUserDetails? userDetails,
    List<GithubOrganization>? userOrganizations,
    bool? isLoading,
    String? errorMessage,
  }) {
    return DetailsState(
      userLogin: userLogin ?? this.userLogin,
      userDetails: userDetails ?? this.userDetails,
      userOrganizations: userOrganizations ?? this.userOrganizations,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        userLogin,
        userDetails,
        userOrganizations,
        isLoading,
        errorMessage,
      ];
}
