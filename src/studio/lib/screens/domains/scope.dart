/// 范围管理
///
/// 遵循《项目管理手册 · 项目范围管理》：收集需求、定义范围、
/// 创建工作分解结构、核实范围、控制范围。

import 'package:flutter/material.dart';
import 'package:graphview/GraphView.dart';

import '../../data/mock.dart';
import '../../models/scope.dart';
import 'domain_page.dart';

/// 范围管理页
class ScopePage extends StatelessWidget {
  const ScopePage({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return DomainPage(
      icon: Icons.track_changes,
      title: '范围管理',
      description: '项目范围管理包括确保项目包含且仅包含完成项目所需的全部工作的过程。'
          '它主要涉及定义和控制项目应该包括和不应该包括的内容。',
      processes: const <String>[
        '收集需求',
        '定义范围',
        '创建WBS',
        '核实范围',
        '控制范围',
      ],
      children: <Widget>[
        // 收集需求
        DomainSection(
          title: '需求收集（Collect Requirements）',
          children: <Widget>[
            for (final Requirement requirement in mockRequirements)
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: CircleAvatar(
                  radius: 14,
                  backgroundColor: theme.colorScheme.secondaryContainer,
                  child: Text(
                    requirement.code.split('-').last,
                    style: theme.textTheme.labelSmall,
                  ),
                ),
                title: Text(requirement.title),
                subtitle: Text(
                  '${requirement.category} · ${requirement.description ?? ''}',
                ),
                trailing: Chip(
                  label: Text(requirement.status),
                  visualDensity: VisualDensity.compact,
                ),
              ),
          ],
        ),
        const SizedBox(height: 16),
        // 定义范围
        const DomainSection(
          title: '范围书（Define Scope）',
          children: <Widget>[
            DomainInfoRow(
              label: '项目目标',
              value: '在 12 个月内完成项目管理云平台建设，支持 1 万用户并发访问，'
                  '系统崩溃率低于 1%，并沉淀可复用的项目管理实践。',
            ),
            DomainInfoRow(
              label: '交付成果',
              value: '平台原型、项目管理模块、范围管理模块、测试报告、用户手册',
            ),
            DomainInfoRow(
              label: '范围边界',
              value: '本期包含：项目、项目集、范围管理能力；'
                  '本期不包含：公告、移动端、采购管理模块。',
            ),
          ],
        ),
        const SizedBox(height: 16),
        // 创建WBS
        DomainSection(
          title: '工作分解结构（Create WBS）',
          children: <Widget>[
            _buildWbsGraph(theme),
          ],
        ),
        const SizedBox(height: 16),
        // 核实范围
        const DomainSection(
          title: '范围核实（Verify Scope）',
          children: <Widget>[
            DomainInfoRow(label: '完整性', value: '目标、工作内容、交付成果均已完整定义'),
            DomainInfoRow(label: '准确性', value: '范围边界清晰，功能与非功能需求表述准确'),
            DomainInfoRow(label: '一致性', value: '范围书内容与组织战略、内部各部分保持一致'),
            DomainInfoRow(label: '可行性', value: '技术、资源、时间均具备可行性'),
          ],
        ),
        const SizedBox(height: 16),
        // 控制范围
        DomainSection(
          title: '范围变更控制（Control Scope）',
          children: <Widget>[
            for (final ScopeChange change in mockScopeChanges)
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Icon(
                  change.status == '已批准'
                      ? Icons.check_circle
                      : change.status == '已拒绝'
                          ? Icons.cancel
                          : Icons.pending,
                  color: change.status == '已批准'
                      ? Colors.green
                      : change.status == '已拒绝'
                          ? Colors.red
                          : Colors.orange,
                ),
                title: Text('${change.code} ${change.title}'),
                subtitle: Text(change.reason),
                trailing: Chip(
                  label: Text(change.status),
                  visualDensity: VisualDensity.compact,
                ),
              ),
          ],
        ),
      ],
    );
  }

  /// WBS 树形图
  Widget _buildWbsGraph(ThemeData theme) {
    // 节点与边
    final Graph graph = Graph()..isTree = true;
    final Map<String, Node> nodes = <String, Node>{};
    for (final WbsNode wbs in mockWbs) {
      nodes[wbs.id] = Node.Id(wbs.code);
    }
    for (final WbsNode wbs in mockWbs) {
      if (wbs.parentId != null && nodes.containsKey(wbs.parentId)) {
        graph.addEdge(nodes[wbs.parentId]!, nodes[wbs.id]!);
      }
    }
    // 算法配置
    final BuchheimWalkerConfiguration config = BuchheimWalkerConfiguration()
      ..siblingSeparation = 40
      ..levelSeparation = 80
      ..subtreeSeparation = 40
      ..orientation = BuchheimWalkerConfiguration.ORIENTATION_TOP_BOTTOM;
    final BuchheimWalkerAlgorithm algorithm =
        BuchheimWalkerAlgorithm(config, TreeEdgeRenderer(config));
    // 编码 -> 标题
    final Map<String, String> titles = <String, String>{
      for (final WbsNode wbs in mockWbs) wbs.code: wbs.title,
    };
    return SizedBox(
      height: 420,
      width: double.infinity,
      child: GraphView(
        graph: graph,
        algorithm: algorithm,
        paint: Paint()
          ..color = theme.colorScheme.outline
          ..strokeWidth = 1
          ..style = PaintingStyle.stroke,
        builder: (Node node) {
          final String code = node.key?.value as String;
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: theme.colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              '$code ${titles[code] ?? ''}',
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onPrimaryContainer,
              ),
            ),
          );
        },
      ),
    );
  }
}
