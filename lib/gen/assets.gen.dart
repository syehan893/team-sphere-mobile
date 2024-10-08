/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';

class $AssetsIconsGen {
  const $AssetsIconsGen();

  /// File path: assets/icons/dollar-coin.png
  AssetGenImage get dollarCoin =>
      const AssetGenImage('assets/icons/dollar-coin.png');

  /// File path: assets/icons/earth-airplane.png
  AssetGenImage get earthAirplane =>
      const AssetGenImage('assets/icons/earth-airplane.png');

  /// File path: assets/icons/home_icon.png
  AssetGenImage get homeIcon =>
      const AssetGenImage('assets/icons/home_icon.png');

  /// File path: assets/icons/news-paper.png
  AssetGenImage get newsPaper =>
      const AssetGenImage('assets/icons/news-paper.png');

  /// File path: assets/icons/profile_icon.png
  AssetGenImage get profileIcon =>
      const AssetGenImage('assets/icons/profile_icon.png');

  /// File path: assets/icons/task_icon.png
  AssetGenImage get taskIcon =>
      const AssetGenImage('assets/icons/task_icon.png');

  /// File path: assets/icons/transaction_icon.png
  AssetGenImage get transactionIcon =>
      const AssetGenImage('assets/icons/transaction_icon.png');

  /// File path: assets/icons/user-multiple-group.png
  AssetGenImage get userMultipleGroup =>
      const AssetGenImage('assets/icons/user-multiple-group.png');

  /// List of all assets
  List<AssetGenImage> get values => [
        dollarCoin,
        earthAirplane,
        homeIcon,
        newsPaper,
        profileIcon,
        taskIcon,
        transactionIcon,
        userMultipleGroup
      ];
}

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/asset-hr-01.png
  AssetGenImage get assetHr01 =>
      const AssetGenImage('assets/images/asset-hr-01.png');

  /// File path: assets/images/location-dynamic-color.png
  AssetGenImage get locationDynamicColor =>
      const AssetGenImage('assets/images/location-dynamic-color.png');

  /// File path: assets/images/logo.png
  AssetGenImage get logo => const AssetGenImage('assets/images/logo.png');

  /// File path: assets/images/tick-dynamic-color.png
  AssetGenImage get tickDynamicColor =>
      const AssetGenImage('assets/images/tick-dynamic-color.png');

  /// List of all assets
  List<AssetGenImage> get values =>
      [assetHr01, locationDynamicColor, logo, tickDynamicColor];
}

class Assets {
  Assets._();

  static const $AssetsIconsGen icons = $AssetsIconsGen();
  static const $AssetsImagesGen images = $AssetsImagesGen();
}

class AssetGenImage {
  const AssetGenImage(
    this._assetName, {
    this.size,
    this.flavors = const {},
  });

  final String _assetName;

  final Size? size;
  final Set<String> flavors;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.low,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({
    AssetBundle? bundle,
    String? package,
  }) {
    return AssetImage(
      _assetName,
      bundle: bundle,
      package: package,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
