import 'package:flutter/material.dart';
import 'package:food_waste_app/donationcenter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:tflite/tflite.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String label = "";
  void classify(String path) async {
    await Tflite.loadModel(
      model: "assets/tflite/expiry.tflite",
      labels: "assets/tflite/expiry.txt",
      isAsset: true,
    );
    List? recognitions = await Tflite.runModelOnImage(
      numResults: 3,
      path: path,
      threshold: 0.5,
    );
    if (recognitions!.isNotEmpty) {
      setState(
        () {
          label = recognitions[0]['label'];
          print(recognitions);
          print(label);
        },
      );
      if (label == "Expired") {
        Alert(
          context: context,
          type: AlertType.warning,
          desc:
              "Your Food is expired!! Please do not consume it and dispose if off.",
          closeFunction: () {
            Navigator.of(context).pop();
          },
          buttons: [
            DialogButton(
              child: const Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        ).show();
      } else if (label == "Unripe") {
        Alert(
          context: context,
          type: AlertType.info,
          desc:
              "Your Food is unripe. Please wait for a few days and then consume.",
          closeFunction: () {
            Navigator.of(context).pop();
          },
          buttons: [
            DialogButton(
              child: const Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        ).show();
      } else {
        Alert(
          context: context,
          type: AlertType.info,
          desc:
              "Your Food is ripe. You can consume it now. If you are unable to consume it within 1-2 days please use our app to donate it to a donation center.",
          closeFunction: () {
            Navigator.of(context).pop();
          },
          buttons: [
            DialogButton(
              child: const Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        ).show();
      }
    } else {
      Alert(
        context: context,
        type: AlertType.error,
        desc: "There was no food detected. Please try again.",
        closeFunction: () {
          Navigator.of(context).pop();
        },
        buttons: [
          DialogButton(
            child: const Text("OK"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          )
        ],
      ).show();
    }
  }

  Future get_image() async {
    Alert(
      context: context,
      type: AlertType.info,
      desc: "Where would you like to select the image from?",
      closeFunction: () {
        Navigator.of(context).pop();
      },
      buttons: [
        DialogButton(
          child: const Icon(
            Icons.camera_alt,
            color: Colors.white,
          ),
          onPressed: () async {
            XFile? file =
                await ImagePicker().pickImage(source: ImageSource.camera);
            if (file != null) {
              Navigator.of(context).pop();
              classify(file.path);
            }
          },
        ),
        DialogButton(
          child: const Icon(
            Icons.photo_library,
            color: Colors.white,
          ),
          onPressed: () async {
            XFile? file =
                await ImagePicker().pickImage(source: ImageSource.gallery);
            if (file != null) {
              Navigator.of(context).pop();
              classify(file.path);
            }
          },
        ),
      ],
    ).show();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Perishably"),
      ),
      body: Column(
        children: [
          Expanded(
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.center,
              //crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(" "),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Align(
                    child: Image.asset(
                      'assets/logo.png',
                      height: height / 4,
                    ),
                    alignment: Alignment.topCenter,
                  ),
                ),
                Expanded(
                  child: SizedBox(
                    width: width,
                    child: GridView.extent(
                      maxCrossAxisExtent: width / 2,
                      semanticChildCount: 2,
                      children: <Widget>[
                        Card(
                          elevation: 6,
                          margin: const EdgeInsets.all(8),
                          child: InkWell(
                            onTap: () {
                              get_image();
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Icon(
                                  Icons.fastfood,
                                  size: width / 8,
                                  color: Colors.grey[800],
                                ),
                                const Padding(
                                  padding: EdgeInsets.all(2),
                                  child: Text(
                                    "Detect how Ripe your Food is",
                                    style: TextStyle(fontSize: 20),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Card(
                          margin: const EdgeInsets.all(8),
                          elevation: 6,
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const DonationCenter(),
                                ),
                              );
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Icon(
                                  Icons.location_on,
                                  size: width / 8,
                                  color: Colors.grey[800],
                                ),
                                const Padding(
                                  padding: EdgeInsets.all(2),
                                  child: Text(
                                    "Locate a donation center",
                                    style: TextStyle(fontSize: 20),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
