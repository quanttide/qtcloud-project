/// 项目管理领域页通用框架
///
/// 每个知识领域页面使用统一的版式：
/// 标题 + 领域定义 + 核心过程 + 自定义内容区。

import 'package:flutter/material.dart';

/// 项目管理领域页
class DomainPage extends StatelessWidget {
  const DomainPage({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
    required this.processes,
    this.children = const <Widget>[],
  });

  /// 领域图标
  final IconData icon;

  /// 领域标题
  final String title;

  /// 领域定义
  final String description;

  /// 核心过程
  final List<String> processes;

  /// 自定义内容区
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return ListView(
      padding: const EdgeInsets.all(24),
      children: <Widget>[
        // 标题
        Row(
          children: <Widget>[
            Icon(icon, size: 32, color: theme.colorScheme.primary),
            const SizedBox(width: 12),
            Text(title, style: theme.textTheme.headlineSmall),
          ],
        ),
        const SizedBox(height: 16),
        // 领域定义
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('领域定义', style: theme.textTheme.titleMedium),
                const SizedBox(height: 8),
                Text(description, style: theme.textTheme.bodyMedium),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        // 核心过程
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('核心过程', style: theme.textTheme.titleMedium),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: <Widget>[
                    for (final String process in processes)
                      Chip(label: Text(process)),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        // 内容区
        ...children,
      ],
    );
  }
}

/// 内容卡片标题
class DomainSection extends StatelessWidget {
  const DomainSection({
    super.key,
    required this.title,
    required this.children,
  });

  /// 小节标题
  final String title;

  /// 小节内容
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(title, style: theme.textTheme.titleMedium),
            const SizedBox(height: 12),
            ...children,
          ],
        ),
      ),
    );
  }
}

/// 键值对行
class DomainInfoRow extends StatelessWidget {
  const DomainInfoRow({super.key, required this.label, required this.value});

  /// 键
  final String label;

  /// 值
  final String value;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ),
          Expanded(child: Text(value, style: theme.textTheme.bodyMedium)),
        ],
      ),
    );
  }
}
