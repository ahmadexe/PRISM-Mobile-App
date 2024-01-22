part of 'configs.dart';

abstract class UIProps {
  // Animations
  static Duration duration0 = const Duration(milliseconds: 150);
  static Duration duration = const Duration(milliseconds: 280);
  static Duration duration2 = const Duration(milliseconds: 400);

  // Paddings
  static EdgeInsets? btnPadMed;
  static EdgeInsets? btnPadSm;

  // Radius
  static double radius = 15;
  static BorderRadius? tabRadius;
  static BorderRadius? buttonRadius;
  static BorderRadius? radiusS;
  static BorderRadius? radiusM;
  static BorderRadius? radiusL;
  static BorderRadius? radiusXL;
  static BoxDecoration? borderButton;
  static BorderRadius? topBoth15;
  static BorderRadius? topBoth30;

  // Shadows
  static List<BoxShadow>? cardShadow;
  static List<BoxShadow>? bottomNavigationShadow;
  // BoxDecoration
  static BoxDecoration? boxCard;

  static init(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(428, 926));

    initRadius(context);
    initButtons();
    initShadows();
    initBoxDecorations();
  }

  static initRadius(BuildContext context) {
    tabRadius = BorderRadius.circular(radius * 2);
    buttonRadius = BorderRadius.circular(radius * 10);

    radiusS = BorderRadius.circular(ScreenUtil().radius(8));
    radiusM = BorderRadius.circular(ScreenUtil().radius(15));
    radiusL = BorderRadius.circular(ScreenUtil().radius(25));
    radiusXL = BorderRadius.circular(ScreenUtil().radius(45));
    topBoth15 = BorderRadius.only(
      topLeft: Radius.circular(ScreenUtil().radius(15)),
      topRight: Radius.circular(ScreenUtil().radius(15)),
    );
    topBoth30 = BorderRadius.only(
      topLeft: Radius.circular(ScreenUtil().radius(25)),
      topRight: Radius.circular(ScreenUtil().radius(25)),
    );
  }

  static initButtons() {
    borderButton = BoxDecoration(
      borderRadius: UIProps.buttonRadius,
      border: Border.all(
        width: 1.4,
        color: AppTheme.c.primary!,
      ),
    );
    btnPadSm = EdgeInsets.symmetric(
      horizontal: AppDimensions.padding! * 2,
      vertical: AppDimensions.padding! * 1.0,
    );
    btnPadMed = EdgeInsets.symmetric(
      horizontal: AppDimensions.padding! * 3,
      vertical: AppDimensions.padding! * 1.5,
    );
  }

  static initShadows() {
    cardShadow = const [
      BoxShadow(
        color: Colors.black12,
        blurRadius: 12,
        spreadRadius: 0,
        offset: Offset(0, 4),
      ),
    ];
    bottomNavigationShadow = [
      BoxShadow(
          color: AppTheme.c.shadowSub!,
          blurRadius: 6,
          spreadRadius: 0,
          offset: const Offset(4, 0)),
    ];
  }

  static initBoxDecorations() {
    boxCard = BoxDecoration(
      borderRadius: radiusM,
      boxShadow: cardShadow,
      color: AppTheme.c.background,
    );
  }
}
