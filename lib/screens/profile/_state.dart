part of 'profile.dart';

class _ScreenState extends ChangeNotifier {
  // ignore: unused_element
  static _ScreenState s(BuildContext context, [listen = false]) =>
      Provider.of<_ScreenState>(context, listen: listen);

  bool isUserFollowed = false;

  void setFollowed(bool value) {
    isUserFollowed = value;
    notifyListeners();
  }

  void toggleFollow() {
    // if (isUserFollowed) {
    //   decreaseFollowers();
    // } else {
    //   increaseFollowers();
    // }
    isUserFollowed = !isUserFollowed;
    notifyListeners();
  }

  // int followers = 0;
  // void setFollowers(int count) {
  //   followers = count;
  //   notifyListeners();
  // }

  // void increaseFollowers() {
  //   followers = followers! + 1;
  //   notifyListeners();
  // }

  // void decreaseFollowers() {
  //   followers = followers! - 1;
  //   notifyListeners();
  // }
}
