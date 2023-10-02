import 'package:gitfolio/data/repositories/connectivity_repository.dart';
import 'package:gitfolio/data/repositories/github/github_organization_repository.dart';
import 'package:gitfolio/data/repositories/github/github_user_details_repository.dart';
import 'package:gitfolio/data/repositories/github/github_user_preview_repository.dart';
import 'package:gitfolio/domain/data_interfaces/github/i_github_organization_repository.dart';
import 'package:gitfolio/domain/data_interfaces/github/i_github_user_details_repository.dart';
import 'package:gitfolio/domain/data_interfaces/github/i_github_user_preview_repository.dart';
import 'package:gitfolio/domain/data_interfaces/i_connectivity_repository.dart';
import 'package:gitfolio/presentation/di/injector.dart';

void initRepositoryModule() {
  i.registerSingleton<IGithubUserPreviewRepository>(
    GithubUserPreviewRepository(i.get()),
  );
  i.registerSingleton<IGithubUserDetailsRepository>(
    GithubUserDetailsRepository(i.get()),
  );
  i.registerSingleton<IGithubOrganizationRepository>(
    GithubOrganizationRepository(i.get()),
  );
  i.registerSingleton<IConnectivityRepository>(ConnectivityRepository());
}
