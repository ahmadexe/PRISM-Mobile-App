import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

IconData getIcon(String domain) {
  switch (domain) {
    case 'Software':
      return Iconsax.code_circle;

    case 'Technology':
      return Iconsax.monitor;

    case 'Health':
      return Iconsax.health;

    case 'Business':
      return Iconsax.activity;

    case 'Education':
      return Iconsax.path;

    default:
      return Iconsax.element_3;
  }
}
