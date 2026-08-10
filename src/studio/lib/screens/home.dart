/// 首页：项目列表
///
/// 展示全部项目（list: `/projects`），点击进入项目详情。

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../data/mock.dart';
import '../models/project.dart';

/// 首页
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('量潮项目管理'),
        centerTitle: false,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: <Widget>[
          // 项目统计概览
          Card(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: <Widget>[
                  Icon(Icons.folder_outlined, color: theme.colorScheme.primary),
                  const SizedBox(width: 12),
                  Text(
                    '共 ${mockProjects.length} 个项目',
                    style: theme.textTheme.titleMedium,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          // 项目列表
          for (final Project project in mockProjects)
            _ProjectCard(project: project),
        ],
      ),
    );
  }
}

/// 项目卡片
class _ProjectCard extends StatelessWidget {
  const _ProjectCard({required this.project});

  /// 项目
  final Project project;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        onTap: () {
          // detail: `/projects/<name>`
          context.push('/projects/${project.name}');
        },
        leading: CircleAvatar(
          backgroundColor: theme.colorScheme.primaryContainer,
          child: Icon(_typeIcon(project.type),
              color: theme.colorScheme.onPrimaryContainer),
        ),
        title: Text(project.title, style: theme.textTheme.titleMedium),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(project.description,
                  maxLines: 2, overflow: TextOverflow.ellipsis),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 4,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: <Widget>[
                  Chip(
                    label: Text(project.type.label),
                    visualDensity: VisualDensity.compact,
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  Chip(
                    label: Text(project.status.label),
                    visualDensity: VisualDensity.compact,
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  Chip(
                    avatar: Icon(
                      _priorityIcon(project.priority),
                      size: 14,
                      color: _priorityColor(project.priority),
                    ),
                    label: Text('${project.priority.label}优先级'),
                    visualDensity: VisualDensity.compact,
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                ],
              ),
            ],
          ),
        ),
        isThreeLine: true,
        trailing: const Icon(Icons.chevron_right),
      ),
    );
  }

  /// 类型图标
  IconData _typeIcon(ProjectType type) {
    switch (type) {
      case ProjectType.program:
        return Icons.account_tree_outlined;
      case ProjectType.projectPortfolio:
        return Icons.widgets_outlined;
      case ProjectType.basic:
        return Icons.folder_outlined;
    }
  }

  /// 优先级图标
  IconData _priorityIcon(ProjectPriority priority) {
    switch (priority) {
      case ProjectPriority.low:
        return Icons.arrow_downward;
      case ProjectPriority.middle:
        return Icons.remove;
      case ProjectPriority.high:
        return Icons.arrow_upward;
      case ProjectPriority.urgent:
        return Icons.priority_high;
    }
  }

  /// 优先级颜色
  Color _priorityColor(ProjectPriority priority) {
    switch (priority) {
      case ProjectPriority.low:
        return Colors.grey;
      case ProjectPriority.middle:
        return Colors.blue;
      case ProjectPriority.high:
        return Colors.orange;
      case ProjectPriority.urgent:
        return Colors.red;
    }
  }
}
