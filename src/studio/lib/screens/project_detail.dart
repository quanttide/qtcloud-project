/// 项目详情页
///
/// 左侧为项目管理知识领域导航，右侧为领域内容。
/// 路由：`/projects/<name>`。

import 'package:flutter/material.dart';

import '../data/mock.dart';
import '../models/project.dart';
import 'domains/communication.dart';
import 'domains/cost.dart';
import 'domains/overview.dart';
import 'domains/procurement.dart';
import 'domains/quality.dart';
import 'domains/resource.dart';
import 'domains/risk.dart';
import 'domains/schedule.dart';
import 'domains/scope.dart';
import 'domains/stakeholder.dart';

/// 领域导航项
class _DomainItem {
  const _DomainItem({
    required this.label,
    required this.icon,
    required this.builder,
  });

  /// 领域名称
  final String label;

  /// 领域图标
  final IconData icon;

  /// 领域内容构建器
  final Widget Function(Project project) builder;
}

/// 项目管理知识领域导航项
final List<_DomainItem> _domainItems = <_DomainItem>[
  _DomainItem(
    label: '概览',
    icon: Icons.info_outline,
    builder: (Project project) => OverviewPage(project: project),
  ),
  const _DomainItem(
    label: '范围',
    icon: Icons.track_changes,
    builder: _buildScope,
  ),
  const _DomainItem(
    label: '进度',
    icon: Icons.schedule,
    builder: _buildSchedule,
  ),
  const _DomainItem(
    label: '成本',
    icon: Icons.payments_outlined,
    builder: _buildCost,
  ),
  const _DomainItem(
    label: '质量',
    icon: Icons.verified_outlined,
    builder: _buildQuality,
  ),
  const _DomainItem(
    label: '资源',
    icon: Icons.groups_outlined,
    builder: _buildResource,
  ),
  const _DomainItem(
    label: '沟通',
    icon: Icons.forum_outlined,
    builder: _buildCommunication,
  ),
  const _DomainItem(
    label: '风险',
    icon: Icons.shield_outlined,
    builder: _buildRisk,
  ),
  const _DomainItem(
    label: '采购',
    icon: Icons.shopping_cart_outlined,
    builder: _buildProcurement,
  ),
  const _DomainItem(
    label: '人员',
    icon: Icons.diversity_1_outlined,
    builder: _buildStakeholder,
  ),
];

Widget _buildScope(Project project) => const ScopePage();
Widget _buildSchedule(Project project) => const SchedulePage();
Widget _buildCost(Project project) => const CostPage();
Widget _buildQuality(Project project) => const QualityPage();
Widget _buildResource(Project project) => const ResourcePage();
Widget _buildCommunication(Project project) => const CommunicationPage();
Widget _buildRisk(Project project) => const RiskPage();
Widget _buildProcurement(Project project) => const ProcurementPage();
Widget _buildStakeholder(Project project) => const StakeholderPage();

/// 项目详情页
class ProjectDetailScreen extends StatefulWidget {
  const ProjectDetailScreen({super.key, required this.projectName});

  /// 项目名称（REST API 标识）
  final String projectName;

  @override
  State<ProjectDetailScreen> createState() => _ProjectDetailScreenState();
}

class _ProjectDetailScreenState extends State<ProjectDetailScreen> {
  /// 当前选中的领域索引
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Project? project = findProjectByName(widget.projectName);
    // 项目不存在时给出提示
    if (project == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('项目详情')),
        body: Center(
          child: Text(
            '未找到项目：${widget.projectName}',
            style: theme.textTheme.bodyLarge,
          ),
        ),
      );
    }
    final _DomainItem selected = _domainItems[_selectedIndex];
    return Scaffold(
      appBar: AppBar(
        title: Text(project.title),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Center(
              child: Chip(
                label: Text(project.status.label),
                visualDensity: VisualDensity.compact,
              ),
            ),
          ),
        ],
      ),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          // 领域导航
          SizedBox(
            width: 220,
            child: Material(
              color: theme.colorScheme.surfaceContainerLow,
              child: ListView(
                padding: const EdgeInsets.symmetric(vertical: 8),
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
                    child: Text(
                      '项目管理框架',
                      style: theme.textTheme.labelMedium?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                  for (int i = 0; i < _domainItems.length; i++)
                    ListTile(
                      selected: i == _selectedIndex,
                      selectedTileColor: theme.colorScheme.secondaryContainer,
                      leading: Icon(_domainItems[i].icon),
                      title: Text(_domainItems[i].label),
                      dense: true,
                      onTap: () {
                        setState(() {
                          _selectedIndex = i;
                        });
                      },
                    ),
                ],
              ),
            ),
          ),
          // 领域内容
          Expanded(
            child: selected.builder(project),
          ),
        ],
      ),
    );
  }
}
