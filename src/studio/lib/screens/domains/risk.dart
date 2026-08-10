/// 风险管理

import 'package:flutter/material.dart';

import '../../data/mock.dart';
import 'domain_page.dart';

/// 风险管理页
class RiskPage extends StatelessWidget {
  const RiskPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DomainPage(
      icon: Icons.shield_outlined,
      title: '风险管理',
      description: '风险管理包括规划风险管理、识别风险、实施风险分析、'
          '规划风险应对、实施风险应对和监督风险的各个过程。',
      processes: const <String>[
        '规划风险',
        '识别风险',
        '定性分析',
        '定量分析',
        '规划应对',
        '实施应对',
        '监督风险',
      ],
      children: <Widget>[
        DomainSection(
          title: '风险登记册',
          children: <Widget>[
            for (final Risk risk in mockRisks)
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Icon(
                  Icons.warning_amber_rounded,
                  color: risk.probability == '高' ? Colors.orange : Colors.amber,
                ),
                title: Text(risk.title),
                subtitle: Text('应对：${risk.response}'),
                trailing: Text(
                  '概率 ${risk.probability} · 影响 ${risk.impact}',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
          ],
        ),
      ],
    );
  }
}
