import 'package:flutter/material.dart';
import 'package:pl_monitor/pages/description.dart';
import 'package:pl_monitor/pages/ecom.dart';
import 'package:pl_monitor/pages/fert_info.dart';
import 'package:pl_monitor/pages/home.dart';

const webScreenSize = 600;

final List<Widget> homeScreenItems = [
  const Home(), // Replace with your actual widget classes
  const Fert(),
  const DescriptionPage(),
  const Ecom()
];
