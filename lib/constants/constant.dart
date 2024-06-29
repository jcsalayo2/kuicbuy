import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

enum AccountStatus { loading, noAccount, hasAccount }

enum ProductStatus { initial, uploading, done, error }

enum ProductDetailsStatus { initial, loading, done, error }

enum GeminiStatus { idle, loading, error }

enum AlgoliaStatus { idle, loading, error }

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

Widget shimmerCard({required BuildContext context, double height = 150}) {
  return Card(
      elevation: 1,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0),
      ),
      child: Container(
        //height: 200,
        height: height,
        // decoration: const BoxDecoration(
        //   borderRadius: BorderRadius.all(Radius.circular(0)),
        // ),
        // child: Column(
        //   mainAxisAlignment: MainAxisAlignment.spaceAround,
        //   crossAxisAlignment: CrossAxisAlignment.stretch,
        //   children: <Widget>[
        //     Stack(children: [
        //       Container(
        //         height: height,
        //       ),
        //     ]),
        //     Container(
        //       width: double.infinity,
        //       height: 20.0,
        //       color: Colors.white,
        //     ),
        //   ],
        // ),
      ));
}

List<FontVariation> fontWeight({required int size}) {
  return [FontVariation('wght', (size).toDouble())];
}
