sealed class UrlStrategy {}

final class PathUrlStrategy extends UrlStrategy {}

void setUrlStrategy(UrlStrategy strategy) {}

void usePathUrlStrategy() {}
