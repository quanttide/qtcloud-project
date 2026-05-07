/// 页面路由和导航栏

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'screens/home.dart';
import 'screens/program.dart';
import 'screens/project.dart';
import 'screens/mettings.dart';
import 'screens/issue.dart';


final GoRouter router = GoRouter(
  routes: <GoRoute>[

    // 首页
    GoRoute(
      name: 'home',
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const HomeScreen();
      },
    ),

    // 项目页面
    GoRoute(
      name: 'project',
      path: '/projects',
      builder: (BuildContext context, GoRouterState state) {
        return const ProjectScreen();
      }
    ),
    // 会议页面
    GoRoute(
      name: 'meeting',
      path: '/meetings',
      builder: (BuildContext context, GoRouterState state){
        return const MeetingScreen();
      }
    ),
    // 议题页面
    GoRoute(
      name: 'issue',
      path: '/issues',
      builder: (BuildContext context, GoRouterState state){
        return const IssueScreen();
      }
    )
  ]
);