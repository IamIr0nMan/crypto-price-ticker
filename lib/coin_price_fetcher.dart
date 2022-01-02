import 'package:bitcoin_price_ticker/coin_data.dart';
import 'package:http/http.dart';
import 'dart:convert';

const String apiKey = '87359274-4659-4E16-8253-F1014330D828';
const String requestURL = 'https://rest.coinapi.io/v1/exchangerate';

class CoinPriceFetcher {
  Future getPrice(String fiatCurrency) async {
    Map<String, String> cryptoPrices = {};
    for (String crypto in cryptoList) {
      Response response = await get(
        Uri.parse('$requestURL/$crypto/$fiatCurrency?apikey=$apiKey'),
      );
      dynamic decodedResponse = jsonDecode(response.body);
      if (response.statusCode == 200) {
        double price = decodedResponse['rate'];
        cryptoPrices[crypto] = price.toStringAsFixed(2);
      } else {
        print(decodedResponse['error']);
        print(response.statusCode);
        throw 'Problem with get request';
      }
    }
    return cryptoPrices;
  }
}
