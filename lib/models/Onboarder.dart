import '../utils/StringsUtils.dart';

class Onboarder {
  late String image;
  late String title;
  late String hint;
  late String? url;

  static List<Onboarder> getOnboardingItems(
      List<String> onboardertitle, List<String> onboarderhints,
      {List<String?>? onboarderUrls}) {
    List<Onboarder> items = [];
    for (int i = 0; i < onboardertitle.length; i++) {
      Onboarder obj = new Onboarder();
      obj.image = StringsUtils.onboarder_image[i];
      obj.title = onboardertitle[i];
      obj.hint = onboarderhints[i];
      obj.url = onboarderUrls?[i];
      items.add(obj);
    }
    return items;
  }
}
