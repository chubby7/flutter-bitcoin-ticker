import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'coin_data.dart';
import 'dart:io' show Platform;

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'AUD';
  Map<String, String> coinValues = {};

  DropdownButton<String> androidDropdown() {
    List<DropdownMenuItem<String>> dropdownItems = [];
    for (String currency in currenciesList) {
      var newItem = DropdownMenuItem(child: Text(currency), value: currency);
      dropdownItems.add(newItem);
    }

    return DropdownButton<String>(
      value: selectedCurrency,
      items: dropdownItems,
      onChanged: (value) {
        setState(() {
          selectedCurrency = value!;
        });
        getData();
      },
    );
  }

  CupertinoPicker iOSPicker() {
    List<Text> pickerItems = [];
    for (String currency in currenciesList) {
      pickerItems.add(Text(currency));
    }

    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedIndex) {
        print(selectedIndex);
        setState(() {
          selectedCurrency = currenciesList[selectedIndex];
          getData();
        });
      },
      children: pickerItems,
    );
  }

  String bitcoinValue = '?';
  String ethereumValue = '?';
  String litecoinValue = '?';

  //TODO 7: Figure out a way of displaying a '?' on screen while we're waiting for the price data to come back. Hint: You'll need a ternary operator.

  //TODO 6: Update this method to receive a Map containing the crypto:price key value pairs. Then use that map to update the CryptoCards.


  // Future<void> getData() async {
  //   try {
  //     CoinData coinData = CoinData(selectedCurrency);
  //     Map<String, String> coinPrices = await coinData.getCoinData();
  //
  //     setState(() {
  //       bitcoinValue = coinPrices['BTC'] ?? '?';
  //       ethereumValue = coinPrices['ETH'] ?? '?';
  //       litecoinValue = coinPrices['LTC'] ?? '?';
  //     });
  //   } catch (e) {
  //     print(e);
  //
  //     setState(() {
  //       bitcoinValue = '?';
  //       ethereumValue = '?';
  //       litecoinValue = '?';
  //     });
  //   }
  // }
  Future<void> getData() async {
    try {
      CoinData coinData = CoinData(selectedCurrency);
      Map<String, String> coinPrices = await coinData.getCoinData();

      setState(() {
        coinValues = coinPrices;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  //TODO: For bonus points, create a method that loops through the cryptoList and generates a CryptoCard for each.
  List<Widget> getCryptoCards(Map<String, String> coinPrices) {
    List<Widget> cryptoCards = [];

    for (String crypto in cryptoList) {
      cryptoCards.add(
        CryptoCard(
          cryptoCurrency: crypto,
          value: coinPrices[crypto] ?? '?',
          selectedCurrency: selectedCurrency,
        ),
      );
    }

    return cryptoCards;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('🤑 Coin Ticker')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: getCryptoCards(coinValues),
          ),

          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isIOS ? iOSPicker() : androidDropdown(),
          ),
        ],
      ),
    );
  }
}

class CryptoCard extends StatelessWidget {
  const CryptoCard({
    super.key,
    required this.cryptoCurrency,
    required this.value,
    required this.selectedCurrency,
  });

  final String cryptoCurrency;
  final String value;
  final String selectedCurrency;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
      child: Card(
        color: Colors.lightBlueAccent,
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
          child: Text(
            '1 $cryptoCurrency = $value $selectedCurrency',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20.0, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
