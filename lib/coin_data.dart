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

// class CoinData {
//   //TODO: Create your getCoinData() method here.
//   Future<dynamic> getCoinData()async{
//     var url = Uri.parse(
//         'https://api-realtime.exrates.coinapi.io/v1/exchangerate/BTC/USD'
//     );
//     var response = await http.get(
//       url,
//       headers: {
//         'Authorization': '0c15be9a-2cfa-4b6e-8b54-f6cff947e85f',
//       },
//     );
//     if (response.statusCode == 200) {
//       var jsonResponse =
//       convert.jsonDecode(response.body) as Map<String, dynamic>;
//       var rate = jsonResponse['rate'];
//       print(rate);
//       return rate;
//     } else {
//       print('Request failed with status: ${response.statusCode}.');
//       return null;
//     }
//   }
// }

class CoinData {
  Future<dynamic> getCoinData() async {
    final url = Uri.parse(
      'https://api.coingecko.com/api/v3/simple/price?ids=bitcoin&vs_currencies=usd',
    );

    final response = await http.get(url);

    print('statusCode: ${response.statusCode}');
    print('body: ${response.body}');
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return (data['bitcoin']['usd'] as num).toDouble();
    } else {
      return null;
    }

}

}

