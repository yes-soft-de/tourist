abstract class NetworkClient {
  Future<Map<String, dynamic>> get(String url);
  Future<Map<String, dynamic>> post(String url, Map<String, dynamic> payload);
  Future<Map<String, dynamic>> put(String url, Map<String, dynamic> payload);
}
