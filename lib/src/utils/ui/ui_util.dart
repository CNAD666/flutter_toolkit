import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

class UiUtil {
  static const Size defaultSize = Size(360, 690);
  static late UiUtil _instance;

  /// UI设计中手机尺寸
  late Size uiSize;

  /// 控制字体是否要根据系统的“字体大小”辅助选项来进行缩放。默认值为false。
  late bool allowFontScaling;

  ///屏幕方向
  late Orientation _orientation;

  late double _pixelRatio;
  late double _textScaleFactor;
  late double _screenWidth;
  late double _screenHeight;
  late double _statusBarHeight;
  late double _bottomBarHeight;

  UiUtil._();

  factory UiUtil() {
    return _instance;
  }

  static void init({
    required Size screenSize,
    Size designSize = defaultSize,
    Orientation orientation = Orientation.portrait,
    bool allowFontScaling = false,
  }) {
    _instance = UiUtil._()
      ..uiSize = designSize
      ..allowFontScaling = allowFontScaling
      .._orientation = orientation;

    if (orientation == Orientation.portrait) {
      _instance._screenWidth = screenSize.width;
      _instance._screenHeight = screenSize.height;
    } else {
      _instance._screenWidth = screenSize.height;
      _instance._screenHeight = screenSize.width;
    }

    var window = WidgetsBinding.instance?.window ?? ui.window;
    _instance._pixelRatio = window.devicePixelRatio;
    _instance._statusBarHeight = window.padding.top;
    _instance._bottomBarHeight = window.padding.bottom;
    _instance._textScaleFactor = window.textScaleFactor;
  }

  ///获取屏幕方向
  Orientation get orientation => _orientation;

  /// 每个逻辑像素的字体像素数，字体的缩放比例
  double get textScaleFactor => _textScaleFactor;

  /// 设备的像素密度
  double get pixelRatio => _pixelRatio;

  /// 当前设备宽度 dp
  double get screenWidth => _screenWidth;

  ///当前设备高度 dp
  double get screenHeight => _screenHeight;

  /// 状态栏高度 dp 刘海屏会更高
  double get statusBarHeight => _statusBarHeight / _pixelRatio;

  /// 底部安全区距离 dp
  double get bottomBarHeight => _bottomBarHeight / _pixelRatio;

  /// 实际尺寸与UI设计的比例
  double get scaleWidth => _screenWidth / uiSize.width;

  double get scaleHeight => _screenHeight / uiSize.height;

  double get scaleText => min(scaleWidth, scaleHeight);

  /// 根据UI设计的设备宽度适配
  double setWidth(num width) => width * scaleWidth;

  /// 根据UI设计的设备高度适配
  /// 高度适配主要针对想根据UI设计的一屏展示一样的效果
  double setHeight(num height) => height * scaleHeight;

  ///根据宽度或高度中的较小值进行适配
  double radius(num r) => r * scaleText;

  ///字体大小适配方法
  double setSp(num fontSize, {bool? allowFontScalingSelf}) =>
      allowFontScalingSelf == null
          ? (allowFontScaling
              ? (fontSize * scaleText) * _textScaleFactor
              : (fontSize * scaleText))
          : (allowFontScalingSelf
              ? (fontSize * scaleText) * _textScaleFactor
              : (fontSize * scaleText));
}
