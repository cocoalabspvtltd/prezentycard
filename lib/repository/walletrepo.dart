
import 'package:dio/dio.dart';

import '../models/getcardlistresp.dart';
import '../network/api_provider.dart';
import '../network/api_provider_prepaid_cards.dart';
import '../network/apis.dart';

class WalletRepository{
  late ApiProvider apiClient;
  var _dio = Dio();

  WalletRepository() {
    apiClient = new ApiProvider();
  }
  Future<GetAllAvailableCardListResponse> getAllAvailableCardList(
      {String? CardId = null}) async {
    final response = await apiClient
        .getJsonInstance()
        .get('${Apis.getAllAvailableCardList}');
    return GetAllAvailableCardListResponse.fromJson(response.data);
  }
}