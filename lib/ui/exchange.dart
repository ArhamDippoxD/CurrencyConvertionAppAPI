import 'package:country_currency_pickers/country.dart';
import 'package:country_currency_pickers/country_picker_dropdown.dart';
import 'package:country_currency_pickers/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../service/apiService.dart';

class Exchange extends StatefulWidget {
  const Exchange({super.key});

  @override
  State<Exchange> createState() => _ExchangeState();
}

class _ExchangeState extends State<Exchange> {
  ApiService apiService=ApiService();
  final _textcontroller=TextEditingController();
  String _selectedBaseCurrency='USD';
  String _selectedTargetCurrency='GBP';
  String _totalValue='';

  Widget _dropDownItem(Country country)=>Container(
    child: Row(
      children: [
        CountryPickerUtils.getDefaultFlagImage(country),
        SizedBox(height: 8,),
        Text('${country.currencyName}'),
      ],
    ),
  );
  @override
  Widget build(BuildContext context) {
    return  Container(
      child: Column(
        children: [
          SizedBox(height: 8),
          Text("Seletec Currency",
            style: TextStyle(
                fontSize: 20,
                color: Colors.white
            ),
          ),
          SizedBox(height: 8),
    Container(
    margin: EdgeInsets.all(10),
    padding: EdgeInsets.all(10),
    decoration: BoxDecoration(color:Colors.white,borderRadius: BorderRadius.circular(10)),

    child: CountryPickerDropdown(
    initialValue:'us',
    itemBuilder:_dropDownItem ,
    onValuePicked: (Country?country){
    setState(() {
    _selectedBaseCurrency=country?.currencyCode ?? "";
    });
    }
    ),
    ),
          SizedBox(height: 20),
          SizedBox(width: 300,
          child: TextField(
            controller: _textcontroller,
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),
            decoration: InputDecoration(
              fillColor: Colors.white,
              filled: true,
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(50),
              )
            ),
          ),),
          SizedBox(height: 15),
          Text("Choose Currency",
            style: TextStyle(
                fontSize: 20,
                color: Colors.white
            ),
          ),
          SizedBox(height: 8),
          Container(
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(color:Colors.white,borderRadius: BorderRadius.circular(10)),

            child: CountryPickerDropdown(
                initialValue:'GB',
                itemBuilder:_dropDownItem ,
                onValuePicked: (Country?country){
                  setState(() {
                    _selectedTargetCurrency=country?.currencyCode ?? "";
                  });
                }
            ),
          ),
          SizedBox(height: 15),
          ElevatedButton(onPressed: () async {
            if(_textcontroller.text.isNotEmpty){
              await apiService.GetExchange(_selectedBaseCurrency, _selectedTargetCurrency).then((result) {
                double value=double.parse(_textcontroller.text);
                double exchangeRate=double.parse(result[0].value.toString());
                double total = value * exchangeRate;
                _totalValue=total.toStringAsFixed(2).toString();
                setState(() {});
              });
            }
          }, child: Text("Exchange",),),
          SizedBox(height: 15),
          Text(_totalValue+" "+_selectedTargetCurrency,
            style: TextStyle(fontSize: 55,color: Colors.greenAccent),),

        ],
      ),
    );
  }
}
