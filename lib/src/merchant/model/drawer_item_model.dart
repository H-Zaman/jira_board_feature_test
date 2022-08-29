import 'package:flutter/material.dart';

class DrawerItemModel{
  final String label;
  final IconData icon;
  final VoidCallback? onPressed;

  DrawerItemModel({
    required this.icon,
    required this.label,
    this.onPressed
  });

}