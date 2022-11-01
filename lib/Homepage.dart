import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

import 'package:searchbar_animation/searchbar_animation.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var FetchData;
  TextStyle textStyle = TextStyle(fontSize: 20, fontWeight: FontWeight.bold);
  TextStyle textStyle2 = TextStyle(fontSize: 15, fontWeight: FontWeight.bold);
  bool? isloaded = false;
  String val = '';
  @override
  void initState() {
    super.initState();
    FetchDataFARAPI(val);
  }

  TextEditingController SearchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SearchBarAnimation(
          durationInMilliSeconds: 400,
          onPressButton: (isOpen) {
            print('done');
          },
          enableBoxBorder: true,
          searchBoxColour: Colors.grey[200],
          searchBoxBorderColour: Colors.blueAccent,
          enableKeyboardFocus: true,
          enableBoxShadow: true,
          isSearchBoxOnRightSide: true,
          buttonWidget: Icon(Icons.search_sharp),
          secondaryButtonWidget: Icon(
            Icons.close,
            color: Colors.grey,
            size: 25,
          ),
          textEditingController: SearchController,
          isOriginalAnimation: false,
          buttonBorderColour: Colors.black45,
          trailingWidget: Icon(
            Icons.search_sharp,
            size: 25,
            color: Colors.blueAccent,
          ),
          onChanged: (value) {
            debugPrint('onFieldSubmitted value $value');

            return FetchDataFARAPI(value);
          },
        ),
      ),
      body: FetchData == null
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: EdgeInsets.all(10),
              child: Card(
                  color: Colors.green[100],
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: Column(
                                children: [
                                  Text(
                                    'PLAYER DETAILS',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 25),
                                  ),
                                  // CircleAvatar(
                                  //   backgroundColor: Colors.transparent,
                                  //   radius: 30,
                                  //   backgroundImage: NetworkImage(
                                  //       FetchData['league']['iconUrls']
                                  //               ['medium']
                                  //           .toString()),
                                  // )
                                ],
                              ),
                            ),

                            Text(
                              'Name :    ' + FetchData['name'],
                              style: textStyle,
                            ),
                            Text(
                              'TownHall Level :   ' +
                                  FetchData['townHallLevel'].toString(),
                              style: textStyle2,
                            ),
                            Text(
                              'TownHall WeaponLevel :   ' +
                                  FetchData['townHallWeaponLevel'].toString(),
                              style: textStyle2,
                            ),
                            Text(
                              'ExpLevel :   ' +
                                  FetchData['expLevel'].toString(),
                              style: textStyle2,
                            ),
                            Text(
                              'Trophies :   ' +
                                  FetchData['trophies'].toString(),
                              style: textStyle2,
                            ),
                            Text(
                              'Best Trophies :   ' +
                                  FetchData['bestTrophies'].toString(),
                              style: textStyle2,
                            ),
                            Text(
                              'War Stars :   ' +
                                  FetchData['warStars'].toString(),
                              style: textStyle2,
                            ),
                            Text(
                              'Attack Wins :   ' +
                                  FetchData['attackWins'].toString(),
                              style: textStyle2,
                            ),
                            Text(
                              'Defense Wins :   ' +
                                  FetchData['defenseWins'].toString(),
                              style: textStyle2,
                            ),
                            Text(
                              'Donations :   ' +
                                  FetchData['donations'].toString(),
                              style: textStyle2,
                            ),
                            Text(
                              'Donations Received :   ' +
                                  FetchData['donationsReceived'].toString(),
                              style: textStyle2,
                            ),
                            // Text(
                            //   'clan :   ' +
                            //           FetchData['clan']['name'].toString() ??
                            //       'ok',
                            //   style: textStyle2,
                            // ),
                            // Text(
                            //   'League :   ' +
                            //       FetchData['league']['name'].toString(),
                            //   style: textStyle2,
                            // ),
                          ]),
                    ),
                  )),
            ),
    );
  }

  FetchDataFARAPI(value) async {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization':
          ''
    };

    var response = await get(
      Uri.parse('https://api.clashofclans.com/v1/players/%23$value'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      setState(() {});
      try {
        setState(() {
          FetchData = jsonDecode(utf8.decode(response.bodyBytes));
          print(FetchData);
        });
      } catch (e) {
        print(FetchData);
        FetchData = null;
      }
    } else {
      print(response.reasonPhrase);
    }
  }
}
