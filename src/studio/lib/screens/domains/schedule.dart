/// 进度管理

import 'package:flutter/material.dart';

import '../../data/mock.dart';
import 'domain_page.dart';

/// 进度管理页
class SchedulePage extends StatelessWidget {
  const SchedulePage({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return DomainPage(
      icon: Icons.schedule,
      title: '进度管理',
      description: '进度管理包括保证项目按时完成所需的各个过程：'
          '规划进度管理、定义活动、排列活动顺序、估算活动持续时间、'
          '制定进度计划和控制进度。',
      processes: const <String>[
        '规划进度',
        '定义活动',
        '排列活动顺序',
        '估算持续时间',
        '制定进度计划',
        '控制进度',
      ],
      children: <Widget>[
        DomainSection(
          title: '里程碑计划',
          children: <Widget>[
            for (final Milestone milestone in mockMilestones)
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Icon(
                  milestone.status == '已完成'
                      ? Icons.check_circle
                      : milestone.status == '进行中'
                          ? Icons.radio_button_checked
                          : Icons.radio_button_unchecked,
                  color: milestone.status == '已完成'
                      ? Colors.green
                      : milestone.status == '进行中'
                          ? theme.colorScheme.primary
                          : theme.colorScheme.outline,
                ),
                title: Text(milestone.title),
                subtitle: Text(
                  '${milestone.date.year}-'
                  '${milestone.date.month.toString().padLeft(2, '0')}-'
                  '${milestone.date.day.toString().padLeft(2, '0')}',
                ),
                trailing: Chip(
                  label: Text(milestone.status),
                  visualDensity: VisualDensity.compact,
                ),
              ),
          ],
        ),
      ],
    );
  }
}
