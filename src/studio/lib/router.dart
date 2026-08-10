/// 页面路由
///
/// - `/`：首页（项目列表）
/// - `/projects/<name>`：项目详情（项目管理框架）

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'screens/home.dart';
import 'screens/project_detail.dart';

final GoRouter router = GoRouter(
  routes: <GoRoute>[
    // 首页：项目列表
    GoRoute(
      name: 'home',
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const HomeScreen();
      },
    ),
    // 项目详情：项目管理框架
    GoRoute(
      name: 'project',
      path: '/projects/:name',
      builder: (BuildContext context, GoRouterState state) {
        return ProjectDetailScreen(
          projectName: state.pathParameters['name'] ?? '',
        );
      },
    ),
  ],
);
