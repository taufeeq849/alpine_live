// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:alpine_live/models/channel_model.dart';
import 'package:alpine_live/models/video_model.dart';
import 'package:alpine_live/models/video_view_argumentmodel.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../ui/views/home/home_view.dart';
import '../ui/views/video_view/video_view.dart';

class Routes {
  static const String homeView = '/';
  static const String videoView = '/video-view';
  static const all = <String>{
    homeView,
    videoView,
  };
}

class Router extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(Routes.homeView, page: HomeView),
    RouteDef(Routes.videoView, page: VideoView),
  ];

  @override
  Map<Type, AutoRouteFactory> get pagesMap => _pagesMap;

  final _pagesMap = <Type, AutoRouteFactory>{
    HomeView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => HomeView(),
        settings: data,
      );
    },
    VideoView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) {
          VideoViewArgumentModel argumentModel = data.arguments;
          return VideoView(argumentModel.video, argumentModel.channel);
        },
        settings: data,
      );
    },
  };
}


