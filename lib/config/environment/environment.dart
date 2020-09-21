import 'package:sso_futurescape/config/environment/production.dart';
import 'package:sso_futurescape/config/environment/stage.dart';

import 'config.dart';

class Environment {
  static Config config = Production();

  Config getCurrentConfig() {
    return config;
  }

  void setCurrentConfig(Config configx) {
    config = configx;
  }

  @deprecated
  getCurrentPlatform() {
    return getCurrentConfig().geCurrentPlatForm();
  }
}

class AppPlatform {
  double getAppVersion() {
    return 1;
  }
}
