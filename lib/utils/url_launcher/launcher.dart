// ignore_for_file: non_constant_identifier_names

import 'package:url_launcher/url_launcher.dart';

class AppLauncher {
  static launchURL({url}) async {
    // ignore: deprecated_member_use
    await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';
  }

  static launchCaller({Url}) async {
    final url = 'tel:+1 $Url';
    // ignore: deprecated_member_use
    if (await canLaunch(url)) {
      // ignore: deprecated_member_use
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  static launchEmail({email}) async {
    // ignore: deprecated_member_use
    if (await canLaunch("mailto:$email")) {
      // ignore: deprecated_member_use
      await launch("mailto:$email");
    } else {
      throw 'Could not launch';
    }
  }
}
