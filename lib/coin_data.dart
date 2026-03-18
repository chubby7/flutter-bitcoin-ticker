import 'dart:convert';
import 'package:http/http.dart' as http;

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

const coinAPIURL = 'https://api.coingecko.com/api/v3/simple/price';


class CoinData {
  //TODO 3: Update getCoinData to take the selectedCurrency as an input.
  CoinData(this.selectedCurrency);
  String selectedCurrency;
  Future<dynamic> getCoinData() async {
    //TODO 4: Update the URL to use the selectedCurrency input.
    final url = Uri.parse(
      '$coinAPIURL?ids=bitcoin&vs_currencies=${selectedCurrency.toLowerCase()}',
    );

    final response = await http.get(url);


    print('body: ${response.body}');
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return (data['bitcoin'][selectedCurrency.toLowerCase()] as num).toDouble();
    } else {
      print('statusCode: ${response.statusCode}');
      throw 'problem with the get request';
    }

}

}

