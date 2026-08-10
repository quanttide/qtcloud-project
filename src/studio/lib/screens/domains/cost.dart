/// 成本管理

import 'package:flutter/material.dart';

import '../../data/mock.dart';
import 'domain_page.dart';

/// 成本管理页
class CostPage extends StatelessWidget {
  const CostPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    double totalBudget = 0;
    double totalSpent = 0;
    for (final CostItem item in mockCostItems) {
      totalBudget += item.budget;
      totalSpent += item.spent;
    }
    return DomainPage(
      icon: Icons.payments_outlined,
      title: '成本管理',
      description: '成本管理包括规划、估算、预算、融资、筹资、管理和控制项目成本'
          '的各个过程，确保项目在批准的预算内完成。',
      processes: const <String>['规划成本', '估算成本', '制定预算', '控制成本'],
      children: <Widget>[
        DomainSection(
          title: '成本预算与执行',
          children: <Widget>[
            for (final CostItem item in mockCostItems)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      '${item.title}：已支出 ¥${item.spent.toStringAsFixed(0)}'
                      ' / 预算 ¥${item.budget.toStringAsFixed(0)}',
                      style: theme.textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 4),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: LinearProgressIndicator(
                        value: item.spent / item.budget,
                        minHeight: 6,
                        color: item.spent / item.budget > 0.8
                            ? Colors.orange
                            : theme.colorScheme.primary,
                        backgroundColor:
                            theme.colorScheme.surfaceContainerHighest,
                      ),
                    ),
                  ],
                ),
              ),
            const SizedBox(height: 8),
            DomainInfoRow(
              label: '总计',
              value: '已支出 ¥${totalSpent.toStringAsFixed(0)}'
                  ' / 预算 ¥${totalBudget.toStringAsFixed(0)}',
            ),
          ],
        ),
      ],
    );
  }
}
