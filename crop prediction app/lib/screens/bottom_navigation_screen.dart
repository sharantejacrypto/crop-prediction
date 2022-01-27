import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import '../components/rounded_button.dart';
import '../networking/networking.dart';
import '../screens/pie_chart.dart';
import '../utilities/constants.dart';

class BottomNavigationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyStatefulWidget(),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  MyStatefulWidget({Key key}) : super(key: key);

  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  int _selectedIndex;
  String tf0, tf1, tf2, tf3, tf4, tf5, tf6;
  String selectedNavigationPageTitle;
  Widget selectedNavigationPageBody;
  String responseTextOfCropPrediction;
  NetworkHelper networkHelper;
  Map<String, String> formBody;
  bool showSpinner;
  File _image;
  ImagePicker picker;

  @override
  void initState() {
    super.initState();
    _selectedIndex = 0;
    selectedNavigationPageTitle = "Home";
    selectedNavigationPageBody = Center(
      child: Text(
        'Home Content',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.lightBlueAccent,
          fontSize: 30,
        ),
      ),
    );
    responseTextOfCropPrediction = '';
    networkHelper = NetworkHelper();
    picker = new ImagePicker();
    showSpinner = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          selectedNavigationPageTitle,
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: ModalProgressHUD(
          inAsyncCall: showSpinner,
          child: selectedNavigationPageBody,
        ),
      ),
      bottomNavigationBar: Theme(
        data: ThemeData(
          canvasColor: Colors.white,
        ),
        child: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                size: 30,
                color: getIconColor(0),
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: SizedBox(
                width: 30,
                height: 23,
                child: Image.asset(
                  'images/plant.png',
                  color: getIconColor(1),
                ),
              ),
              label: 'Crop',
            ),
            BottomNavigationBarItem(
              icon: SizedBox(
                width: 53,
                height: 33,
                child: Image.asset(
                  'images/plant_disease.png',
                  color: getIconColor(2),
                ),
              ),
              label: 'Disease',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.account_circle_rounded,
                size: 30,
                color: getIconColor(3),
              ),
              label: 'Profile',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.blueGrey,
          onTap: _onItemTapped,
        ),
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      switch (index) {
        case 0:
          {
            selectedNavigationPageTitle = "Home";
            selectedNavigationPageBody = homePage();
          }
          break;
        case 1:
          {
            selectedNavigationPageTitle = "Crop Identification";
            selectedNavigationPageBody = cropPredictionPage();
          }
          break;
        case 2:
          {
            selectedNavigationPageTitle = "Disease Prediction";
            selectedNavigationPageBody = diseaseIdentificationPage();
          }
          break;
        case 3:
          {
            selectedNavigationPageTitle = "Profile";
            selectedNavigationPageBody = profilePage();
          }
          break;
      }
      _selectedIndex = index;
    });
  }

  Color getIconColor(int index) {
    return _selectedIndex == index ? Colors.green : Colors.black;
  }

  Widget homePage() {
    return Center(
      child: Text(
        'Home Content',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.lightBlueAccent,
          fontSize: 30,
        ),
      ),
    );
  }

  Widget cropPredictionPage() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: TextField(
                onChanged: (value) {
                  try {
                    double.parse(value);
                    tf0 = value;
                  } catch (err) {
                    tf0 = null;
                  }
                },
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                decoration: kTextFieldDecoration.copyWith(
                  hintText: 'Nitrogen',
                ),
              ),
            ),
            SizedBox(
              width: 2.0,
            ),
            Expanded(
              child: TextField(
                onChanged: (value) {
                  try {
                    double.parse(value);
                    tf1 = value;
                  } catch (err) {
                    tf1 = null;
                  }
                },
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                decoration: kTextFieldDecoration.copyWith(
                  hintText: 'Phosphorus',
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 4.0,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: TextField(
                onChanged: (value) {
                  try {
                    double.parse(value);
                    tf2 = value;
                  } catch (err) {
                    tf2 = null;
                  }
                },
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                decoration: kTextFieldDecoration.copyWith(
                  hintText: 'Potassium',
                ),
              ),
            ),
            SizedBox(
              width: 2.0,
            ),
            Expanded(
              child: TextField(
                onChanged: (value) {
                  try {
                    double.parse(value);
                    tf3 = value;
                  } catch (err) {
                    tf3 = null;
                  }
                },
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                decoration: kTextFieldDecoration.copyWith(
                  hintText: 'Temperature',
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 4.0,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: TextField(
                onChanged: (value) {
                  try {
                    double.parse(value);
                    tf4 = value;
                  } catch (err) {
                    tf4 = null;
                  }
                },
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                decoration: kTextFieldDecoration.copyWith(
                  hintText: 'Humidity',
                ),
              ),
            ),
            SizedBox(
              width: 2.0,
            ),
            Expanded(
              child: TextField(
                onChanged: (value) {
                  try {
                    double.parse(value);
                    tf5 = value;
                  } catch (err) {
                    tf5 = null;
                  }
                },
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                decoration: kTextFieldDecoration.copyWith(
                  hintText: 'PH',
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 4.0,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: TextField(
                onChanged: (value) {
                  try {
                    double.parse(value);
                    tf6 = value;
                  } catch (err) {
                    tf6 = null;
                  }
                },
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                decoration: kTextFieldDecoration.copyWith(
                  hintText: 'Rainfall',
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          width: 8.0,
        ),
        RoundedButton(Colors.lightBlueAccent, 'Submit', () async {
          if (tf0 != null &&
              tf1 != null &&
              tf2 != null &&
              tf3 != null &&
              tf4 != null &&
              tf5 != null &&
              tf6 != null) {
            formBody = {
              'MobileApp': tf0,
              'tf1': tf1,
              'tf2': tf2,
              'tf3': tf3,
              'tf4': tf4,
              'tf5': tf5,
              'tf6': tf6,
            };
            setState(() {
              showSpinner = true;
              responseTextOfCropPrediction = '';
            });
            responseTextOfCropPrediction =
                await networkHelper.predictCrop(formBody);
            setState(() {
              selectedNavigationPageBody = cropPredictionPage();
              showSpinner = false;
            });
          } else {
            setState(() {
              responseTextOfCropPrediction = "All fields are required.";
              selectedNavigationPageBody = cropPredictionPage();
            });
          }
        }),
        SizedBox(
          width: 8.0,
        ),
        Center(
          child: Text(
            responseTextOfCropPrediction,
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
      ],
    );
  }

  Widget diseaseIdentificationPage() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          RoundedButton(Colors.lightBlueAccent, 'Choose a file', () {
            makeDiseaseIdentificationRequest('gallery');
          }),
          Text(
            'OR',
            style: TextStyle(
              fontSize: 15.0,
              fontWeight: FontWeight.w400,
            ),
          ),
          RoundedButton(Colors.lightBlueAccent, 'Take a picture', () {
            makeDiseaseIdentificationRequest('camera');
          }),
        ],
      ),
    );
  }

  void makeDiseaseIdentificationRequest(String source) async {
    PickedFile pickedFile;
    try {
      if (source == 'gallery') {
        pickedFile = await picker.getImage(source: ImageSource.gallery);
      } else {
        pickedFile = await picker.getImage(source: ImageSource.camera);
      }
      if (pickedFile != null) {
        setState(() {
          showSpinner = true;
        });
        _image = File(pickedFile.path);
        final bytes = await _image.readAsBytes();
        String img64 = base64Encode(bytes);
        Map<String, dynamic> res = await networkHelper.identifyDisease(img64);
        setState(() {
          showSpinner = false;
        });
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PieChartSample2(res),
          ),
        );
      } else {
        print('No file chosen.');
      }
    } catch (err) {
      print('Something went wrong.');
      print(err);
    }
  }

  Widget profilePage() {
    return Center(
      child: Text(
        'Profile Content',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.lightBlueAccent,
          fontSize: 30,
        ),
      ),
    );
  }
}
