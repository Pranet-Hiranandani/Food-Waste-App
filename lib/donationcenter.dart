import 'package:flutter/material.dart';
import 'package:food_waste_app/home.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_webview_pro/webview_flutter.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:url_launcher/url_launcher.dart';

class DonationCenter extends StatefulWidget {
  const DonationCenter({Key? key}) : super(key: key);

  @override
  _DonationCenterState createState() => _DonationCenterState();
}

class _DonationCenterState extends State<DonationCenter> {
  bool webview = false;
  Future load() async {
    PermissionStatus permission = await Permission.location.request();
    if (permission.isGranted) {
      setState(
        () {
          webview = true;
        },
      );
    } else {
      Alert(
        context: context,
        type: AlertType.warning,
        desc:
            "Enable location permission to use the locate donation center feature.",
        closeFunction: () {},
        buttons: [
          DialogButton(
            child: const Text("OK"),
            onPressed: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Home(),
                ),
              );
            },
          )
        ],
      ).show();
    }
  }
  
  @override
  void initState() {
    super.initState();
    load();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: const Text("Perishably"),
      ),
      body: Visibility(
        child: WebView(
          initialUrl:
              "https://www.google.com/maps/search/nearest+food+donation+center/",
          javascriptMode: JavascriptMode.unrestricted,
          navigationDelegate: (NavigationRequest request) async {
            await launch(request.url);
            return NavigationDecision.navigate;
          },
          geolocationEnabled: true,
        ),
      ),
    );
  }
}
