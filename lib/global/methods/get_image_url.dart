import '../../app/repository/api_endpoint.dart';

class GetImageUrl {
  static String url(String url) {
    return '${ApiEndpoint.domainUrl}/$url';
  }
}
