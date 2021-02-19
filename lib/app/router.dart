import 'package:alpine_live/ui/views/home/home_view.dart';
import 'package:alpine_live/ui/views/video_view/video_view.dart';
import 'package:auto_route/auto_route_annotations.dart';


@MaterialAutoRouter(
  routes: <AutoRoute>[
    MaterialRoute(page: HomeView, initial: true),
    MaterialRoute(page: VideoView),
  ],
)
class $Router {}
