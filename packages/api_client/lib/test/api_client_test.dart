import 'package:api_client/src/api_client.dart';
import 'package:api_client/src/models/request_status.dart';
// ignore: depend_on_referenced_packages
import 'package:test/test.dart';

void main() {
  test('get beers', () async {
    ApiClient apiClient = ApiClient();
    var result = await apiClient.getBeers();
    expect(result.status, RequestStatus.SUCCESS);
  });
}
