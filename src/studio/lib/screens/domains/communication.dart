/// 沟通管理

import 'package:flutter/material.dart';

import '../../data/mock.dart';
import 'domain_page.dart';

/// 沟通管理页
class CommunicationPage extends StatelessWidget {
  const CommunicationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DomainPage(
      icon: Icons.forum_outlined,
      title: '沟通管理',
      description: '沟通管理包括为确保项目信息及时且恰当地规划、收集、生成、'
          '发布、存储、检索、管理、控制、监督和最终处置所需的各个过程。',
      processes: const <String>['规划沟通', '管理沟通', '监督沟通'],
      children: <Widget>[
        DomainSection(
          title: '沟通计划',
          children: <Widget>[
            for (final Communication communication in mockCommunications)
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.event_note_outlined),
                title: Text(communication.name),
                subtitle: Text('面向：${communication.audience}'),
                trailing: Chip(
                  label: Text(communication.frequency),
                  visualDensity: VisualDensity.compact,
                ),
              ),
          ],
        ),
      ],
    );
  }
}
