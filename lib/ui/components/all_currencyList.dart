import 'package:currency_conversion/model/currencyModel.dart';
import 'package:flutter/material.dart';

class AllCurrencyList extends StatelessWidget {
  final CurrencyModel currencyModel;
  const AllCurrencyList({Key?key,required this.currencyModel}):super(key:key);

  @override
  Widget build(BuildContext context) {
    return  Container(
      padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
      margin: EdgeInsets.all(9),
      decoration: BoxDecoration(
        color: Colors.blueGrey.withAlpha(88),
        borderRadius: BorderRadius.circular(10),),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            currencyModel.code.toString(),style: TextStyle(
            color: Colors.white,fontSize: 17,
          ),
          ),

          Text(
            currencyModel.value?.toStringAsFixed(2).toString() ?? "",
            style: TextStyle(
            color: Colors.white,fontSize: 17,
          ),
          ),
        ],
      ),
    );
  }
}
