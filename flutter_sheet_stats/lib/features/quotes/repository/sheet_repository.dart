import 'package:flutter_sheet_stats/network/network_helper.dart';
import 'package:flutter_sheet_stats/network/network_service.dart';

import '../../../models/sheet_model.dart';

class SheetRepository {
  final String _baseUrl = "https://herrcomockapifunc.azurewebsites.net/api/getProducts";

  Future<Sheet> getQuote() async {
    final response = await NetworkService.sendRequest(
        requestType: RequestType.get, url: _baseUrl);

    return NetworkHelper.filterResponse(
        callBack: (json) => Sheet.fromJson(json),
        response: response,
        onFailureCallBackWithMessage: (errorType, msg) =>
        throw Exception('An Error has happened. $errorType - $msg'));
  }
}