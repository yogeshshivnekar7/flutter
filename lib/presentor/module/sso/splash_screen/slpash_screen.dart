import 'package:sso_futurescape/config/environment/environment.dart';
import 'package:sso_futurescape/model/app/app_model.dart';

class SplashScreenPresentor {
  IAppUpdate slashView;

  SplashScreenPresentor(IAppUpdate slashView) {
    this.slashView = slashView;
  }

  void updateCheck() {
    print("Update checking");
    AppModel appModel = new AppModel();
    try {
      double currentVersion = Environment()
          .getCurrentConfig()
          .getCurrentVersion();
      print("DDDDDDDDDDDDDDDDDD $currentVersion");
      appModel.getAppUpdate(currentVersion, slashView.hasUpdate,
          slashView.hasNoUpdate);
    } catch (e) {
      print(e);
    }

  }
}
