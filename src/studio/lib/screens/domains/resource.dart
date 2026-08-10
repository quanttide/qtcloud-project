/// 资源管理

import 'package:flutter/material.dart';

import '../../data/mock.dart';
import 'domain_page.dart';

/// 资源管理页
class ResourcePage extends StatelessWidget {
  const ResourcePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DomainPage(
      icon: Icons.groups_outlined,
      title: '资源管理',
      description: '资源管理包括识别、获取和管理成功完成项目所需的资源'
          '（人力、设备、材料等）的各个过程。',
      processes: const <String>[
        '规划资源',
        '估算活动资源',
        '获取资源',
        '建设团队',
        '管理团队',
        '控制资源',
      ],
      children: <Widget>[
        DomainSection(
          title: '项目团队',
          children: <Widget>[
            for (final TeamMember member in mockTeamMembers)
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const CircleAvatar(child: Icon(Icons.person_outline)),
                title: Text(member.name),
                subtitle: Text(member.role),
                trailing: Chip(
                  label: Text('投入 ${member.workload}'),
                  visualDensity: VisualDensity.compact,
                ),
              ),
          ],
        ),
      ],
    );
  }
}
