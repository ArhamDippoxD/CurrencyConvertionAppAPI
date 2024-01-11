import 'package:country_currency_pickers/country.dart';
import 'package:country_currency_pickers/country_pickers.dart';
import 'package:currency_conversion/service/apiService.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


import '../model/currencyModel.dart';
import 'components/all_currencyList.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  ApiService apiService=ApiService();
    String _selectedCurrency='USD';
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
    return
      Container(
      child: Column(
        children: [
          SizedBox(height: 8),
          Text("Selected Currency",
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
                _selectedCurrency=country?.currencyCode ?? "";
              });
            },
          ),
        ),
          SizedBox(height: 8),
          Text("All Currency",
            style: TextStyle(
                fontSize: 20,
                color: Colors.white
            ),
          ),
          SizedBox(height: 8),
          FutureBuilder( builder: (context,snapshot){
          if (snapshot.hasData) {
            List<CurrencyModel> currencyModelList=snapshot.data ?? [];
            return Expanded(child: ListView.builder(itemBuilder: (context,index){
              return AllCurrencyList(currencyModel: currencyModelList[index]);
            },itemCount:currencyModelList.length ,),
            );
          }
          if(snapshot.hasError){
            return Center(child: Text("Error occured",style: TextStyle(color:Colors.white,),),);
          }
          else
            return const Center(
            child: CircularProgressIndicator(),
          );
          },future: apiService.GetLatest(_selectedCurrency),)
        ],

      ),
      );
  }
}
