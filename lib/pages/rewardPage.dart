import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../common/current.dart';
import '../common/design.dart';
import '../common/sideMenu.dart';


class RewardsPage extends StatefulWidget {
  @override
  _RewardsPageState createState() => _RewardsPageState();
}

class SizeConfig {
  static MediaQueryData _mediaQueryData;
  static double screenWidth;
  static double screenHeight;
  static double blockSizeHorizontal;
  static double blockSizeVertical;
  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    blockSizeHorizontal = screenWidth / 100;
    blockSizeVertical = screenHeight / 100;
  }
}

class _RewardsPageState extends State<RewardsPage> {
  int selectedIndex = 0;
  PickedFile imageFile;
  final ImagePicker _picker = ImagePicker();

  PickedFile imageFile2;
  final ImagePicker _picker2 = ImagePicker();

  _openGallery(BuildContext context) async {
    final pickedFile = await _picker.getImage(source: ImageSource.gallery);
    setState(() {
      imageFile = pickedFile;
    });
    Navigator.of(context).pop();
  }

  _openGallery2(BuildContext context) async {
    final pickedFile = await _picker2.getImage(source: ImageSource.gallery);
    setState(() {
      imageFile2 = pickedFile;
    });
    Navigator.of(context).pop();
  }

  // _openCamera(BuildContext context) async {
  //   final pickedFile = await _picker.getImage(source: ImageSource.camera);
  //   setState(() {
  //     imageFile = pickedFile;
  //   });
  //   Navigator.of(context).pop();
  // }



// first photo
  Future<void> _showChoiceDialog(BuildContext context) {
    return showDialog(context: context,builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Please select one:"),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              GestureDetector(
                child: Text("Gallery"),
                onTap: () {
                  _openGallery(context);
                },
              ),
              Padding(padding: EdgeInsets.all(8.0)),
              // GestureDetector(
              //   child: Text("Camera"),
              //   onTap: () {
              //     _openCamera(context);
                ],),
              ),
          );
    },);
  }

  Widget _cameraIcon1() {
    return Center(
      child: Stack(children: <Widget>[
        Positioned(
          bottom: 2.0,
          right: 2.0,
          child: InkWell(
            onTap: () {
              _showChoiceDialog(context);
            },
            child: Icon(
              Icons.camera_alt,
              color: Colors.deepOrange,
              size: 28.0,
            ),
          ),
        ),],
      ),
    );
  }



  Widget _decideImageView1() {
    if (imageFile == null) {
      return Text("Select a reward image with the camera icon!", style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w500,
      ),);
    } else {
      return Image.file(File(imageFile.path), fit: BoxFit.cover);
    }
  }


  // second photo
  Future<void> _showChoiceDialog2(BuildContext context) {
    return showDialog(context: context,builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Please select one:"),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              GestureDetector(
                child: Text("Gallery"),
                onTap: () {
                  _openGallery2(context);
                },
              ),
              Padding(padding: EdgeInsets.all(8.0)),
              // GestureDetector(
              //   child: Text("Camera"),
              //   onTap: () {
              //     _openCamera(context);
            ],),),
      );
    });
  }
  // 2nd camera path
  Widget _cameraIcon2() {
    return Center(
      child: Stack(children: <Widget>[
        Positioned(
          bottom: 2.0,
          right: 2.0,
          child: InkWell(
            onTap: () {
              _showChoiceDialog2(context);
            },
            child: Icon(
              Icons.camera_alt,
              color: Colors.deepOrange,
              size: 28.0,
            ),
          ),
        ),],
      ),
    );
  }


  Widget _decideImageView2() {
    if (imageFile2 == null) {
      return Text("Select a reward image with the camera icon!", style: TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w500,
      ),);
    } else {
      return Image.file(File(imageFile2.path), fit: BoxFit.cover);
    }
  }



  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Theme(
      data: defaultTheme,
    child: Scaffold(
        appBar: AppBar(
          title: Text("🏆 Rewards"),
        ),
        drawer: SideMenu(),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: SizeConfig.blockSizeVertical * 2, width: 50),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Welcome to Your Rewards Page!", style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                            color: Colors.grey.shade800
                        ),),

                      ]),
                  SizedBox(),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                    Text("Your total points: ", style: TextStyle(
                              color: Colors.grey.shade500,
                              fontSize: 22,
                            ),),


                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(Current.profile.pointsAvailable.toString(), style: TextStyle(
                                color: Colors.deepOrange,
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),),
                            ]
                          ),
                        ),
                    ]),



                  // Picture Rewards
                  SizedBox(height: SizeConfig.blockSizeVertical * 3, width: SizeConfig.blockSizeVertical * 3),
                  SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          Container(
                            height: SizeConfig.blockSizeVertical * 20,
                            width: SizeConfig.blockSizeHorizontal * 41,
                            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(20)),
                                color: Colors.grey.shade300,
                                boxShadow: [BoxShadow(spreadRadius: 0, offset: Offset(0, 10), blurRadius: 0, color: Colors.orange.withOpacity(0.4))]
                            ),
                            child: Column(
                              children: <Widget>[
                                Expanded(
                                    child: Container(
                                      child: Stack(
                                        fit: StackFit.expand,
                                        children: <Widget> [
                                          _decideImageView1(),
                                          Container(
                                            child: _cameraIcon1(),
                                          ),
                                        ],
                                      ),
                                    )
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: SizeConfig.blockSizeVertical * 3, width: SizeConfig.blockSizeVertical * 3,),
                          Column(
                            children: [
                              Container(
                                height: SizeConfig.blockSizeVertical * 20,
                                width: SizeConfig.blockSizeHorizontal * 41,
                                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(20)),
                                    color: Colors.grey.shade300,
                                    boxShadow: [BoxShadow(spreadRadius: 0, offset: Offset(0, 10), blurRadius: 0, color: Colors.orange.withOpacity(0.4))]
                                ),
                                child: Column(
                                  children: <Widget>[
                                    Expanded(
                                        child: Container(
                                          child: Stack(
                                            fit: StackFit.expand,
                                            children: <Widget> [
                                              _decideImageView2(),
                                              Container(
                                                child: _cameraIcon2(),
                                              ),
                                            ],
                                          ),
                                        )
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      )
                  ),


                  // Points boxes

                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(

                      children: <Widget>[
                        Container(
                          height: SizeConfig.blockSizeVertical * 10,
                          width: SizeConfig.blockSizeHorizontal * 41,
                          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                          //padding: EdgeInsets.fromLTRB(43, 20, 50, 20),
                          child: Column(
                            children: <Widget>[
                              Container(
                                  height: SizeConfig.blockSizeVertical * 5,
                                  width: SizeConfig.blockSizeVertical * 10,
                                  child: TextField(
                                    textAlign: TextAlign.center,
                                    decoration: InputDecoration(
                                      labelText: 'Points',
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.orange, width: 3),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(16),
                                        borderSide: BorderSide(color: Colors.orange, width: 3),
                                      ),
                                  ),)),
                            ],
                          ),
                        ),

                        // 2nd point box
                        Container(
                          height: SizeConfig.blockSizeVertical * 10,
                          width: SizeConfig.blockSizeHorizontal * 52,
                          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                          child: Column(
                            children: <Widget>[
                              Container(
                                height: SizeConfig.blockSizeVertical * 5,
                                width: SizeConfig.blockSizeVertical * 10,
                                  child: TextField(
                                    textAlign: TextAlign.center,
                                    decoration: InputDecoration(
                                      labelText: 'Points',
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.orange, width: 3),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(16),
                                        borderSide: BorderSide(color: Colors.orange, width: 3),
                                      ),
                                    ),
                                  ),),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),


                  // Reward Coupons section
                  Divider(
                    color: Colors.deepOrange,
                    indent: 10,
                    endIndent: 10,
                    height: 10,
                    thickness: 3,
                  ),

                  SizedBox(height: 20,),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text("Reward Coupons", style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700
                      ),),
                    ],
                  ),

                  SingleChildScrollView(
                    padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
                    child: Column(
                        children: <Widget>[
                          TextFormField(
                            textCapitalization: TextCapitalization.words,
                            decoration: InputDecoration(
                              hintText: "Example: Pick your own cereal. (200 points).",
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.orange, width: 3),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: BorderSide(color: Colors.orange, width: 3),
                              ),
                              //border: UnderlineInputBorder(),
                              filled: true,
                            ),
                          )
                        ]
                    ),
                  ),


                  // 2nd coupon

                  SingleChildScrollView(
                    padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
                    child: Column(
                        children: <Widget>[
                          TextFormField(
                            textCapitalization: TextCapitalization.words,
                            decoration: InputDecoration(
                              hintText: "Example: Pick your own cereal. (200 points).",
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.orange, width: 3),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: BorderSide(color: Colors.orange, width: 3),
                              ),
                              //border: UnderlineInputBorder(),
                              filled: true,
                            ),
                          )
                        ]
                    ),
                  ),

                  // 3rd coupon

                  SingleChildScrollView(
                    padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
                    child: Column(
                        children: <Widget>[
                          TextFormField(
                            textCapitalization: TextCapitalization.words,
                            decoration: InputDecoration(
                              hintText: "Example: Pick your own cereal. (200 points).",
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.orange, width: 3),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: BorderSide(color: Colors.orange, width: 3),
                              ),
                              //border: UnderlineInputBorder(),
                              filled: true,
                            ),
                          )
                        ]
                    ),
                  ),

                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                  child: ElevatedButton(
                      onPressed: () {},
                  child: const Text('Redeem a reward!', style: TextStyle(
                      fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.black)),
                ),
                ),
                ),
                ],
              ),
            ),
          ),
        )
    ),);
  }
}