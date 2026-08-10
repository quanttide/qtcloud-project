/// 质量管理

import 'package:flutter/material.dart';

import '../../data/mock.dart';
import 'domain_page.dart';

/// 质量管理页
class QualityPage extends StatelessWidget {
  const QualityPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DomainPage(
      icon: Icons.verified_outlined,
      title: '质量管理',
      description: '质量管理包括规划质量管理、管理质量和控制质量的过程，'
          '以及支持持续改进的组织过程资产。',
      processes: const <String>['规划质量', '管理质量', '控制质量'],
      children: <Widget>[
        DomainSection(
          title: '质量指标',
          children: <Widget>[
            for (final QualityMetric metric in mockQualityMetrics)
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.monitor_heart_outlined),
                title: Text(metric.title),
                subtitle: Text('目标：${metric.target}'),
                trailing: Chip(
                  label: Text('当前 ${metric.current}'),
                  visualDensity: VisualDensity.compact,
                ),
              ),
          ],
        ),
      ],
    );
  }
}
