import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../logic/service.dart';
import '../../shared/styles/appClrs.dart';
import '../../global/responsive.dart';
import 'searchNotesResults.dart';

class SearchInitScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(responsive.responsiveHigh(context, 0.07)),
          child: AppBar(
            leading: IconButton(icon: Icon(Icons.arrow_back_ios_outlined),
                onPressed: ()=> Navigator.pop(context)),
            title: Consumer<DataSavedService>(
              builder:(_,prov,__)=> TextField(
                textInputAction: TextInputAction.search,
                autofocus: true,
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(width: 2)
                  ),
                  filled: true,
                  contentPadding: EdgeInsets.symmetric(vertical: 0,horizontal: 8),
                ),
                onSubmitted: (val){
                  prov.setSearchWord(val);
                  prov.searchNotes(val);
                  Navigator.push(context, CupertinoPageRoute(builder: (_)=>SearchNotesResults(val)));
                },
              ),
            ),
          ),
        ),

        body: Container(
          width: responsive.sWidth(context),
          height: responsive.sHeight(context),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              SizedBox(height: responsive.responsiveHigh(context, 0.05),),

              Text(
                'Enter a few words to search in notes',
                style: TextStyle(fontWeight: FontWeight.w600),
                textAlign: TextAlign.center,
              ),

              SizedBox(height: responsive.responsiveHigh(context, 0.01),),

              CircleAvatar(
                backgroundColor: appClrs.mainColor,
                radius: responsive.textScale(context)*45,
                child: Icon(Icons.search ,color: Colors.black87,size: responsive.textScale(context)*73),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
