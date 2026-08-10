/// 项目概览
///
/// 展示项目基本字段信息（《项目规范》定义的 `Project` 模型字段）。

import 'package:flutter/material.dart';

import '../../models/project.dart';
import 'domain_page.dart';

/// 项目概览页
class OverviewPage extends StatelessWidget {
  const OverviewPage({super.key, required this.project});

  /// 当前项目
  final Project project;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return DomainPage(
      icon: Icons.info_outline,
      title: '项目概览',
      description: '项目的基本信息与状态概览，字段定义遵循《项目规范》'
          '（id、name、title、description、type、hierarchy、status、priority、created_at、updated_at）。',
      processes: const <String>['类型', '层级', '状态', '优先级'],
      children: <Widget>[
        DomainSection(
          title: '基本信息',
          children: <Widget>[
            DomainInfoRow(label: '名称', value: project.name),
            DomainInfoRow(label: '标题', value: project.title),
            DomainInfoRow(label: '描述', value: project.description),
            DomainInfoRow(label: '创建时间', value: _formatDate(project.createdAt)),
            DomainInfoRow(label: '更新时间', value: _formatDate(project.updatedAt)),
          ],
        ),
        const SizedBox(height: 16),
        DomainSection(
          title: '项目属性',
          children: <Widget>[
            DomainInfoRow(label: '类型', value: project.type.label),
            DomainInfoRow(label: '层级', value: '${project.hierarchy}（0 为根层级）'),
            DomainInfoRow(label: '状态', value: project.status.label),
            DomainInfoRow(label: '优先级', value: project.priority.label),
            DomainInfoRow(
              label: 'REST API',
              value: 'list: /projects · detail: /projects/${project.name}',
            ),
          ],
        ),
        const SizedBox(height: 16),
        // 提示：左侧导航进入各管理领域
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: <Widget>[
                Icon(Icons.tips_and_updates_outlined,
                    color: theme.colorScheme.primary),
                const SizedBox(width: 12),
                const Expanded(
                  child: Text(
                    '通过左侧导航栏可进入范围、进度、成本、质量、资源、沟通、'
                    '风险、采购、人员等项目管理知识领域。',
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-'
        '${date.day.toString().padLeft(2, '0')}';
  }
}
