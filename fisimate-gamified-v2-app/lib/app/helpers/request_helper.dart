import 'package:http_parser/http_parser.dart';

class RequestHelper {
  static MediaType getImageContentType(String path) {
    if (path.endsWith('.png')) {
      return MediaType('image', 'png');
    } else if (path.endsWith('.jpg')) {
      return MediaType('image', 'jpg');
    } else if (path.endsWith('.jpeg')) {
      return MediaType('image', 'jpeg');
    } else {
      throw Exception('Unsupported image type');
    }
  }
}
