import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bitcoin_price_ticker/coin_data.dart';
import 'package:bitcoin_price_ticker/coin_price_fetcher.dart';
import 'package:bitcoin_price_ticker/crypto_price_card.dart';
import 'dart:io' show Platform;

class PriceScreen extends StatefulWidget {
  const PriceScreen({Key? key}) : super(key: key);

  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  CoinPriceFetcher priceFetcher = CoinPriceFetcher();
  String currencyValue = 'USD';
  bool isWaiting = false;
  Map<String, String> priceValues = {};

  void getPrice() async {
    try {
      var data = await priceFetcher.getPrice(currencyValue);
      setState(() {
        priceValues = data;
      });
    } catch (e) {
      print(e);
    }
  }

  DropdownButton<String> getDropdownButton() {
    List<DropdownMenuItem<String>> dropDownItems = [];
    for (String currency in currenciesList) {
      var newItem = DropdownMenuItem(
        child: Text(currency),
        value: currency,
      );
      dropDownItems.add(newItem);
    }
    return DropdownButton<String>(
      value: currencyValue,
      items: dropDownItems,
      onChanged: (value) {
        setState(() {
          currencyValue = value!;
          getPrice();
        });
      },
    );
  }

  CupertinoPicker getCupertinoPicker() {
    List<Widget> pickers = [];
    for (String currency in currenciesList) {
      pickers.add(Text(currency));
    }
    return CupertinoPicker(
      itemExtent: 32.0,
      onSelectedItemChanged: (int value) {
        print(value);
      },
      children: pickers,
    );
  }

  Column getPriceCards() {
    List<Widget> priceCards = [];
    for (String crypto in cryptoList) {
      var newItem = Padding(
        padding: const EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
        child: PriceCard(
          crypto: crypto,
          fiat: currencyValue,
          price: isWaiting ? '?' : priceValues[crypto].toString(),
        ),
      );
      priceCards.add(newItem);
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: priceCards,
    );
  }

  @override
  void initState() {
    super.initState();
    getPrice();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          getPriceCards(),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: const EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isIOS ? getCupertinoPicker() : getDropdownButton(),
          ),
        ],
      ),
    );
  }
}
