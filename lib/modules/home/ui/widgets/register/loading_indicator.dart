import 'package:flutter/material.dart';

const g1c1 = Color.fromRGBO(244, 221, 88, 1);
const g1c2 = Color.fromRGBO(208, 53, 242, 1);
const g2c1 = Color.fromRGBO(225, 49, 243, 1);
const g2c2 = Color.fromRGBO(5, 0, 242, 1);
const g3c1 = Color.fromRGBO(230, 53, 35, 1);
const g3c2 = Color.fromRGBO(250, 245, 81, 1);

final tweens = [
  TweenSequenceItem(
    tween: Tween(begin: Offset(0, -30), end: Offset(-30, 30)),
    weight: 1 / 6,
  ),
  TweenSequenceItem(
    tween: Tween(begin: Offset(-30, 30), end: Offset(-30, 30)),
    weight: 1 / 6,
  ),
  TweenSequenceItem(
    tween: Tween(begin: Offset(-30, 30), end: Offset(30, 30)),
    weight: 1 / 6,
  ),
  TweenSequenceItem(
    tween: Tween(begin: Offset(30, 30), end: Offset(30, 30)),
    weight: 1 / 6,
  ),
  TweenSequenceItem(
    tween: Tween(begin: Offset(30, 30), end: Offset(0, -30)),
    weight: 1 / 6,
  ),
  TweenSequenceItem(
    tween: Tween(begin: Offset(0, -30), end: Offset(0, -30)),
    weight: 1 / 6,
  ),
];
