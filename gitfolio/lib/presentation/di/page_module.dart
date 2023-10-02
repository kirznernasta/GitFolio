import 'package:gitfolio/presentation/di/injector.dart';
import 'package:gitfolio/presentation/pages/preview/preview_page.dart';

void initPageModule(){
  i.registerFactory<PreviewPage>(PreviewPage.new);
}
