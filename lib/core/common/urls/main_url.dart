export 'package:seo_web/core/common/urls/main_url_web.dart'
    if (dart.library.http) 'package:seo_web/core/common/urls/main_url_web.dart'
    if (dart.library.io) 'package:seo_web/core/common/urls/main_url_mobile.dart';
