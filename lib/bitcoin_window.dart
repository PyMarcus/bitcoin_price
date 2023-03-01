import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class BitcoinCurrentPrice extends StatefulWidget {
  const BitcoinCurrentPrice({Key? key}) : super(key: key);

  @override
  _BitcoinCurrentPriceState createState() => _BitcoinCurrentPriceState();
}

class _BitcoinCurrentPriceState extends State<BitcoinCurrentPrice> {


    Map<String, dynamic> data_from_api = Map();

  _getApiData() async
  {
    http.Response response;
    String url = "https://blockchain.info/ticker";

    try{
      response = await http.get(url);
      print(response.statusCode);
      if(response.statusCode == 200){
           data_from_api = json.decode(response.body);
           print(data_from_api);
      }
    }catch(e){
      print(e);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text("BitCoin Price",
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),backgroundColor: Colors.amber[800]),


      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center,
          children: [
          Padding(padding: EdgeInsets.all(32), child: Image.asset("assets/bitcoin.png"),),
          Padding(padding: EdgeInsets.all(8), child: Text("R\$ ${data_from_api['BRL']['last']}", style: TextStyle(color: Colors.black, fontSize: 25),),),


          Padding(padding: EdgeInsets.all(8), child: ElevatedButton(onPressed: () { _getApiData(); },
          child: Text("Refresh", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),), style: ButtonStyle(padding: MaterialStateProperty.all(const EdgeInsets.only(left:50,top: 20,right: 50,bottom: 20),),
                backgroundColor: MaterialStateProperty.all(
                    Colors.amber[800]),
                foregroundColor: MaterialStateProperty.all(Colors.white),)),),
        ],),
      ),
    );
  }
}
