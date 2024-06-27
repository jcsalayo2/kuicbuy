import 'dart:ui';

import 'package:intl/intl.dart';

enum AccountStatus { loading, noAccount, hasAccount }

enum ProductStatus { initial, uploading, done, error }

final oCcy = NumberFormat("#,##0.00", "en_US");

Path roundedDottedBorder(size) {
  var cardRadius = 10.0;

  return Path()
    ..moveTo(cardRadius, 0)
    ..lineTo(size.width - cardRadius, 0)
    ..arcToPoint(Offset(size.width, cardRadius),
        radius: Radius.circular(cardRadius))
    ..lineTo(size.width, size.height - cardRadius)
    ..arcToPoint(Offset(size.width - cardRadius, size.height),
        radius: Radius.circular(cardRadius))
    ..lineTo(cardRadius, size.height)
    ..arcToPoint(Offset(0, size.height - cardRadius),
        radius: Radius.circular(cardRadius))
    ..lineTo(0, cardRadius)
    ..arcToPoint(Offset(cardRadius, 0), radius: Radius.circular(cardRadius));
}
