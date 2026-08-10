/// 人员管理

import 'package:flutter/material.dart';

import '../../data/mock.dart';
import 'domain_page.dart';

/// 人员管理页
class StakeholderPage extends StatelessWidget {
  const StakeholderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DomainPage(
      icon: Icons.diversity_1_outlined,
      title: '人员管理',
      description: '人员管理包括识别能影响项目或受项目影响的个人或群体，'
          '分析他们对项目的期望和影响，并制定合适的策略来有效调动人员参与'
          '项目决策和执行。',
      processes: const <String>[
        '识别人员',
        '规划人员参与',
        '管理人员参与',
        '监督人员参与',
      ],
      children: <Widget>[
        DomainSection(
          title: '人员清单',
          children: <Widget>[
            for (final Stakeholder stakeholder in mockStakeholders)
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const CircleAvatar(child: Icon(Icons.person_outline)),
                title: Text(stakeholder.name),
                subtitle: Text(stakeholder.role),
                trailing: Chip(
                  label: Text('参与度 ${stakeholder.participation}'),
                  visualDensity: VisualDensity.compact,
                ),
              ),
          ],
        ),
      ],
    );
  }
}
