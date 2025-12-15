import 'package:recipe_app/core/api/end_ponits.dart';

class ImageHelper {
  static String imageBase = 'assets/images/';
  static String iconBase = 'assets/icons/';

  static String authPicture = '${imageBase}auth_pic.png';
  static String d1 = '${imageBase}d1.png';
  static String d2 = '${imageBase}d2.png';
  static String d3 = '${imageBase}d3.png';
  static String d4 = '${imageBase}d4.png';
  static String d5 = '${imageBase}d5.png';
  static String logoDark = '${imageBase}logo_dark.svg';
  static String logoLight = '${imageBase}logo_light.svg';

  static String background = '${imageBase}background.svg';
  static String profilePic = '${imageBase}profile.jpg';

  static String atSign = '${iconBase}at-sign.svg';
  static String plus = '${iconBase}plus.svg';
  static String trash = '${iconBase}trash.svg';
  static String upload = '${iconBase}upload.svg';
  static String chevronsLeft = '${iconBase}chevrons-left.svg';
  static String chevronsRight = '${iconBase}chevrons-right.svg';
  static String chevronLeft = '${iconBase}chevron-left.svg';
  static String chevronRight = '${iconBase}chevron-right.svg';
  static String messageCircle = '${iconBase}message-circle.svg';
  static String edit = '${iconBase}edit-2.svg';
  static String eyeOff = '${iconBase}eye-off.svg';
  static String file = '${iconBase}file-text.svg';
  static String logOut = '${iconBase}log-out.svg';
  static String eye = '${iconBase}eye.svg';
  static String home = '${iconBase}home.svg';
  static String pc = '${iconBase}monitor.svg';
  static String moon = '${iconBase}moon.svg';
  static String search = '${iconBase}search.svg';
  static String settings = '${iconBase}settings.svg';
  static String sliders = '${iconBase}sliders.svg';
  static String smartphone = '${iconBase}smartphone.svg';
  static String sun = '${iconBase}sun.svg';
  static String tablet = '${iconBase}tablet.svg';
  static String user = '${iconBase}user.svg';
  static String feather = '${iconBase}feather.svg';
  static String frown = '${iconBase}frown.svg';
  static String key = '${iconBase}key.svg';
  static String mail = '${iconBase}mail.svg';
  static String x = '${iconBase}x.svg';
  static String smile = '${iconBase}smile.svg';
  static String rice = '${iconBase}rice.svg';
  static String friedEgg = '${iconBase}fried-egg.svg';
  static String salad = '${iconBase}salad.svg';
  static String sandwich = '${iconBase}sandwich.svg';
  static String grid = '${iconBase}grid.svg';
  static String muffin = '${iconBase}muffin.svg';

  static String fixImageUrl(String url) {
    return url.replaceFirst('http://localhost:8000/', EndPoint.baseUrl);
  }
}
