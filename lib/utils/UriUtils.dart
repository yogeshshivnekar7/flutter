import 'package:sso_futurescape/utils/app_constant.dart';
import 'package:uri/uri.dart';

class UriUtils {

  static Map<String, String> parseUrl(String url, UriTemplate uriTemplate) {
    if (url == null || url.trim().isEmpty) {
      return null;
    }

    if(uriTemplate == null) {
      return null;
    }

    UriParser uriParser = UriParser(uriTemplate);
    Uri uri = Uri.dataFromString(url.trim());
    if (uri == null) {
      return null;
    }

    Map<String, String> uriParams;
    try {
      uriParams = uriParser.parse(uri);
    } catch (e) {
      print(e);
      return null;
    }

    return uriParams;
  }

  static String getUrlScheme(String url) {
    if (url == null || url.trim().isEmpty) {
      return null;
    }

    if (url.trim().startsWith(AppConstant.SCHEME_HTTPS)) {
      return AppConstant.SCHEME_HTTPS;
    } else if (url.trim().startsWith(AppConstant.SCHEME_HTTP)) {
      return AppConstant.SCHEME_HTTP;
    }

    return null;
  }

  static bool isHttpUrl(String url) {
    return AppConstant.SCHEME_HTTP == getUrlScheme(url);
  }

  static bool isHttpsUrl(String url) {
    return AppConstant.SCHEME_HTTPS == getUrlScheme(url);
  }
}