import 'package:expense_tracker/constants/colors.dart';
import 'package:flutter/material.dart';


class FontSizes {
  FontSizes._();
  static const double scale = 1;
  static const double s10 = 10 * scale;
  static const double s11 = 11 * scale;
  static const double s12 = 12 * scale;
  static const double s14 = 14 * scale;
  static const double s16 = 16 * scale;
  static const double s18 = 18 * scale;
  static const double s20 = 20 * scale;
  static const double s22 = 22 * scale;
  static const double s24 = 24 * scale;
}

class TextStyles {
  TextStyles._();

  static const h1 = TextStyle(color: AppColors.white, fontWeight: FontWeight.w900, fontSize: FontSizes.s24);
  static const h1Dark = TextStyle(color: AppColors.dark, fontWeight: FontWeight.w900, fontSize: FontSizes.s24);
  static const h2 = TextStyle(color: AppColors.white, fontWeight: FontWeight.w600, fontSize: FontSizes.s22);
  static const h3 = TextStyle(color: AppColors.dark, fontWeight: FontWeight.w600, fontSize: FontSizes.s20);
  static const h4 = TextStyle(color: AppColors.white, fontWeight: FontWeight.w500, fontSize: FontSizes.s18);
  static const h5 = TextStyle(color: AppColors.white, fontSize: FontSizes.s16);
  static const h6 = TextStyle(color: AppColors.dark, fontSize: FontSizes.s14);
  static const description = TextStyle(color: AppColors.grey, fontSize: FontSizes.s14);
}

class Shadows {
  Shadows._();

  static bool enabled = true;

  static List<BoxShadow> custom({Color color = Colors.black, double opacity = 0.015}) => [
    BoxShadow(
      color: color.withOpacity(opacity),
      blurRadius: 8,
      spreadRadius: 4,
      offset: const Offset(1, 0),
    ),
    BoxShadow(
      color: color.withOpacity(opacity),
      blurRadius: 4,
      spreadRadius: 2,
      offset: const Offset(1, 0),
    )
  ];

  static List<BoxShadow> get universal => [
    BoxShadow(
      color: Colors.black.withOpacity(0.015),
      blurRadius: 8,
      spreadRadius: 4,
      offset: const Offset(1, 0),
    ),
    BoxShadow(
      color: Colors.black.withOpacity(0.015),
      blurRadius: 4,
      spreadRadius: 2,
      offset: const Offset(1, 0),
    )
  ];

  static List<BoxShadow> get sm => [
    BoxShadow(color: Colors.black.withOpacity(0.015), spreadRadius: 0, blurRadius: 3, offset: const Offset(0, 1)),
  ];

  static List<BoxShadow> get md => [
    BoxShadow(
        color: const Color(0xff333333).withOpacity(.1), spreadRadius: 0, blurRadius: 6, offset: const Offset(0, 1)),
  ];

  static List<BoxShadow> get lg => [
    BoxShadow(color: const Color(0xff333333).withOpacity(.15), spreadRadius: 0, blurRadius: 10),
  ];
}

class Corners {
  Corners._();

  /// Xs
  static const double xs = 3;
  static BorderRadius get xsBorder => BorderRadius.all(xsRadius);
  static Radius get xsRadius => const Radius.circular(xs);

  /// Small
  static const double sm = 5;
  static BorderRadius get smBorder => BorderRadius.all(smRadius);
  static Radius get smRadius => const Radius.circular(sm);

  /// Medium
  static const double md = 8;
  static const BorderRadius mdBorder = BorderRadius.all(mdRadius);
  static const Radius mdRadius = Radius.circular(md);

  /// Large
  static const double lg = 10;
  static BorderRadius get lgBorder => BorderRadius.all(lgRadius);
  static Radius get lgRadius => const Radius.circular(lg);
}
