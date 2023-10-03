import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gitfolio/domain/entities/github_organization.dart';
import 'package:gitfolio/domain/entities/github_user_details.dart';
import 'package:gitfolio/domain/interactors/details_interactor.dart';
import 'package:gitfolio/domain/utils/wrapper.dart';
import 'package:gitfolio/presentation/utils/constants/app_strings.dart';

part 'details_state.dart';

final class DetailsCubit extends Cubit<DetailsState> {
  final DetailsInteractor _detailsInteractor;

  DetailsCubit(
    this._detailsInteractor,
  ) : super(
          const DetailsState(),
        ) {
    _init();
  }

  StreamSubscription<bool>? _connectivitySubscription;

  StreamSubscription<Wrapper<GithubOrganizationList>?>?
      _githubOrganizationListSubscription;

  StreamSubscription<Wrapper<GithubUserDetails>?>?
      _githubUserDetailsSubscription;

  @override
  Future<void> close() {
    _connectivitySubscription?.cancel();
    _connectivitySubscription = null;

    _githubOrganizationListSubscription?.cancel();
    _githubOrganizationListSubscription = null;

    _githubUserDetailsSubscription?.cancel();
    _githubUserDetailsSubscription = null;

    _detailsInteractor.clearDetailsStreams();

    return super.close();
  }

  void fetchUserInformation(String userLogin) {
    _detailsInteractor.getUserDetails(userLogin);
    _detailsInteractor.getUserOrganizations(userLogin);
  }

  void _init() {
    _subscribeAll();
  }

  void _subscribeAll() {
    _githubUserDetailsSubscription?.cancel();
    _githubUserDetailsSubscription =
        _detailsInteractor.githubUserDetailsStream.listen(
      _onNewUserDetails,
    );

    _githubOrganizationListSubscription?.cancel();
    _githubOrganizationListSubscription =
        _detailsInteractor.githubOrganizationListStream.listen(
      _onNewUserOrganizations,
    );
  }

  void _onNewUserDetails(Wrapper<GithubUserDetails>? detailsWrapper) {
    if (detailsWrapper != null) _handleDetailsWrapper(detailsWrapper);
  }

  Future<void> _handleDetailsWrapper(
    Wrapper<GithubUserDetails> detailsWrapper,
  ) async {
    GithubUserDetails? userDetails;
    var errorMessage = '';

    emit(
      state.newState(isLoading: true),
    );

    if (await _detailsInteractor.hasInternetConnection) {
      if (detailsWrapper.isSuccess) {
        userDetails = detailsWrapper.data;
      } else {
        errorMessage = AppStrings.error;
      }
    } else {
      errorMessage = AppStrings.connectionError;
    }
    emit(
      state.newState(
        userDetails: userDetails,
        isLoading: !(userDetails != null && state.userOrganizations != null),
        errorMessage: errorMessage,
      ),
    );
  }

  void _onNewUserOrganizations(
    Wrapper<GithubOrganizationList>? organizationListWrapper,
  ) {
    if (organizationListWrapper != null) {
      _handleOrganizationListWrapper(organizationListWrapper);
    }
  }

  Future<void> _handleOrganizationListWrapper(
    Wrapper<GithubOrganizationList> organizationListWrapper,
  ) async {
    List<GithubOrganization>? userOrganizations;
    var errorMessage = '';

    emit(
      state.newState(isLoading: true),
    );

    if (await _detailsInteractor.hasInternetConnection) {
      if (organizationListWrapper.isSuccess) {
        userOrganizations = organizationListWrapper.data?.organizations;
      } else {
        errorMessage = AppStrings.error;
      }
    } else {
      errorMessage = AppStrings.connectionError;
    }
    emit(
      state.newState(
        userOrganizations: userOrganizations,
        isLoading: !(state.userDetails != null && userOrganizations != null),
        errorMessage: errorMessage,
      ),
    );
  }
}
