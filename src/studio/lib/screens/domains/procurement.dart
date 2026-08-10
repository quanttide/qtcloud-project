/// 采购管理

import 'package:flutter/material.dart';

import '../../data/mock.dart';
import 'domain_page.dart';

/// 采购管理页
class ProcurementPage extends StatelessWidget {
  const ProcurementPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DomainPage(
      icon: Icons.shopping_cart_outlined,
      title: '采购管理',
      description: '采购管理包括从项目团队外部采购或获取产品、服务或成果'
          '的各个过程，以及管理合同与供应商关系。',
      processes: const <String>['规划采购', '实施采购', '控制采购'],
      children: <Widget>[
        DomainSection(
          title: '采购项',
          children: <Widget>[
            for (final Procurement procurement in mockProcurements)
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.inventory_2_outlined),
                title: Text(procurement.title),
                subtitle: Text('供应商：${procurement.supplier}'),
                trailing: Chip(
                  label: Text(procurement.status),
                  visualDensity: VisualDensity.compact,
                ),
              ),
          ],
        ),
      ],
    );
  }
}
