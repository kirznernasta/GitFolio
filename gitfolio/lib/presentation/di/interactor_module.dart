import 'package:gitfolio/domain/interactors/connectivity_interactor.dart';
import 'package:gitfolio/domain/interactors/github_organization_interactor.dart';
import 'package:gitfolio/domain/interactors/github_user_details_interactor.dart';
import 'package:gitfolio/domain/interactors/github_user_preview_interacor.dart';
import 'package:gitfolio/presentation/di/injector.dart';

void initInteractorModule() {
  i.registerFactory<GithubUserPreviewInteractor>(
    () => GithubUserPreviewInteractor(i.get()),
  );
  i.registerFactory<GithubUserDetailsInteractor>(
    () => GithubUserDetailsInteractor(i.get()),
  );
  i.registerFactory<GithubOrganizationInteractor>(
    () => GithubOrganizationInteractor(i.get()),
  );
  i.registerFactory<ConnectivityInteractor>(
    () => ConnectivityInteractor(i.get()),
  );
}
