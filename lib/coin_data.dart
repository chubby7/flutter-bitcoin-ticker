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
  CoinData(this.selectedCurrency);
  String selectedCurrency;

     //TODO 4: Use a for loop here to loop through the cryptoList and request the data for each of them in turn.
     //TODO 5: Return a Map of the results instead of a single value.


  Future<Map<String, String>> getCoinData() async {
    final currency = selectedCurrency.toLowerCase();

    final url = Uri.parse(
      '$coinAPIURL?ids=bitcoin,ethereum,litecoin&vs_currencies=$currency',
    );

    final response = await http.get(url);

    print('statusCode: ${response.statusCode}');
    print('body: ${response.body}');

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      return {
        'BTC': data['bitcoin'][currency].toString(),
        'ETH': data['ethereum'][currency].toString(),
        'LTC': data['litecoin'][currency].toString(),
      };
    } else if (response.statusCode == 429) {
      throw 'Rate limit exceeded. Wait a little and try again.';
    } else {
      throw 'Problem with the get request. Status code: ${response.statusCode}';
    }
  }

}

