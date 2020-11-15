import 'package:flutter/material.dart';
import 'package:flutter_earthquake_network/ui/template/app_theme.dart';

class TabIconData {
  TabIconData({
    this.imagePath, // = '',
    this.index = 0,
    this.selectedImagePath, // = '',
    this.isSelected = false,
    this.animationController,
  });

  Icon imagePath;
  Icon selectedImagePath;
  bool isSelected;
  int index;

  AnimationController animationController;

  static List<TabIconData> tabIconsList = <TabIconData>[
    TabIconData(
      imagePath: Icon(
        Icons.public,
        color: AppTheme.grey.withOpacity(0.6),
        size: 35,
      ),
      selectedImagePath: Icon(
        Icons.public,
        color: AppTheme.nearlyDarkBlue.withOpacity(0.6),
        size: 35,
      ),
      index: 0,
      isSelected: true,
    ),
    TabIconData(
      imagePath: Icon(
        Icons.notifications_none,
        color: AppTheme.grey.withOpacity(0.6),
        size: 36,
      ),
      selectedImagePath: Icon(
        Icons.notifications_none,
        color: AppTheme.nearlyDarkBlue.withOpacity(0.6),
        size: 36,
      ),
      index: 1,
      isSelected: false,
      //animationController: null,
    ),
    TabIconData(
      imagePath: Icon(
        Icons.settings,
        color: AppTheme.grey.withOpacity(0.6),
        size: 36,
      ), //'assets/images/ic-back.png',
      selectedImagePath: Icon(
        Icons.settings,
        color: AppTheme.nearlyDarkBlue.withOpacity(0.6),
        size: 36,
      ), //'assets/images/ic-back.png',
      index: 2,
      isSelected: false,
      //animationController: null,
    ),
    TabIconData(
      imagePath: Icon(
        Icons.help_outline,
        color: AppTheme.grey.withOpacity(0.6),
        size: 36,
      ),
      selectedImagePath: Icon(
        Icons.help_outline,
        color: AppTheme.nearlyDarkBlue.withOpacity(0.6),
        size: 36,
      ),
      index: 3,
      isSelected: false,
    ),
  ];
}
