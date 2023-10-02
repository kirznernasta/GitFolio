import 'dart:async';

import 'package:gitfolio/domain/entities/github_organization.dart';
import 'package:gitfolio/domain/entities/github_user_details.dart';
import 'package:gitfolio/domain/interactors/connectivity_interactor.dart';
import 'package:gitfolio/domain/interactors/github_organization_interactor.dart';
import 'package:gitfolio/domain/interactors/github_user_details_interactor.dart';
import 'package:gitfolio/presentation/base/base_cubit.dart';
import 'package:gitfolio/presentation/pages/details/details_state.dart';
import 'package:gitfolio/presentation/utils/constants/app_strings.dart';

class DetailsCubit extends BaseCubit<DetailsState> {
  final GithubUserDetailsInteractor _detailsInteractor;
  final GithubOrganizationInteractor _organizationInteractor;
  final ConnectivityInteractor _connectivityInteractor;

  StreamSubscription<bool>? _connectivitySubscription;

  DetailsCubit(
    this._detailsInteractor,
    this._organizationInteractor,
    this._connectivityInteractor,
  ) : super(const DetailsState());

  @override
  void init() {
    _connectivitySubscription =
        _connectivityInteractor.connectivityStatus.listen((hasConnection) {
      if (hasConnection && state.userLogin != null) {
        initWithData(state.userLogin!);
      }
    });
  }

  @override
  void dispose() {
    _connectivitySubscription?.cancel();
    _connectivitySubscription = null;
    super.dispose();
  }

  void initWithData(String userLogin) async {
    GithubUserDetails? userDetails;
    var errorMessage = '';
    List<GithubOrganization>? userOrganizations;

    emit(state.newState(isLoading: true));

    if (await _connectivityInteractor.hasConnection) {
      final detailsWrapper = await _detailsInteractor.getUserDetails(userLogin);
      final userOrganizationsWrapper =
          await _organizationInteractor.getUserOrganizations(userLogin);
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
}
