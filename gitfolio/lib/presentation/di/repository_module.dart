import 'package:gitfolio/platform/connectivity/connectivity_client.dart';
import 'package:gitfolio/data/repositories/github/github_organization_repository.dart';
import 'package:gitfolio/data/repositories/github/github_user_details_repository.dart';
import 'package:gitfolio/data/repositories/github/github_user_preview_repository.dart';
import 'package:gitfolio/domain/interfaces/github/i_github_organization_repository.dart';
import 'package:gitfolio/domain/interfaces/github/i_github_user_details_repository.dart';
import 'package:gitfolio/domain/interfaces/github/i_github_user_preview_repository.dart';
import 'package:gitfolio/domain/client_interfaces/i_connectivity_client.dart';
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
  i.registerSingleton<IConnectivityClient>(ConnectivityClient());
}
