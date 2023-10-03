import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gitfolio/domain/entities/github_organization.dart';
import 'package:gitfolio/domain/entities/github_user_details.dart';
import 'package:gitfolio/domain/interactors/details_interactor.dart';
import 'package:gitfolio/presentation/utils/constants/app_strings.dart';

part 'details_state.dart';

final class DetailsCubit extends Cubit<DetailsState> {
  final DetailsInteractor _detailsInteractor;

  StreamSubscription<bool>? _connectivitySubscription;

  DetailsCubit(
    this._detailsInteractor,
  ) : super(
          const DetailsState(),
        ) {
    _init();
  }

  @override
  Future<void> close() {
    _connectivitySubscription?.cancel();
    _connectivitySubscription = null;

    return super.close();
  }

  void initWithData(String userLogin) async {
    GithubUserDetails? userDetails;
    var errorMessage = '';
    List<GithubOrganization>? userOrganizations;

    emit(
      state.newState(isLoading: true),
    );

    if (await _detailsInteractor.hasInternetConnection) {
      final detailsWrapper = await _detailsInteractor.getUserDetails(userLogin);
      final userOrganizationsWrapper =
          await _detailsInteractor.getUserOrganizations(userLogin);
      if (detailsWrapper.isSuccess && userOrganizationsWrapper.isSuccess) {
        userDetails = detailsWrapper.data;
        userOrganizations = userOrganizationsWrapper.data?.organizations;
      } else {
        errorMessage = AppStrings.error;
      }
    } else {
      errorMessage = AppStrings.connectionError;
    }
    emit(
      state.newState(
        userLogin: userLogin,
        userDetails: userDetails,
        userOrganizations: userOrganizations,
        isLoading: false,
        errorMessage: errorMessage,
      ),
    );
  }

  void _init() {
    _connectivitySubscription =
        _detailsInteractor.connectivityStatusStream.listen(
      (hasConnection) {
        if (hasConnection && state.userLogin != null) {
          initWithData(state.userLogin!);
        }
      },
    );
  }
}
