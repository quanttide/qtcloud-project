/// 演示数据
///
/// 后端 API（`lib/api.dart`）接入前的本地模拟数据。
/// REST API 约定：list `/projects`、detail `/projects/<name>`。

import '../models/project.dart';
import '../models/scope.dart';

/// 项目列表
final List<Project> mockProjects = <Project>[
  Project(
    id: 'p-001',
    name: 'knowledge-management',
    title: '量潮知识管理体系',
    description: '建设统一的知识管理体系，覆盖项目管理、学习平台等领域，沉淀组织智慧。',
    createdAt: DateTime(2025, 1, 6),
    updatedAt: DateTime(2026, 8, 1),
    type: ProjectType.program,
    hierarchy: 0,
    status: ProjectStatus.inProgress,
    priority: ProjectPriority.high,
  ),
  Project(
    id: 'p-002',
    name: 'qtcloud-project',
    title: '量潮项目管理云',
    description: '项目管理云服务：项目全生命周期管理的平台化实现，包括范围、进度、风险等管理能力。',
    createdAt: DateTime(2025, 6, 18),
    updatedAt: DateTime(2026, 8, 10),
    type: ProjectType.basic,
    hierarchy: 1,
    status: ProjectStatus.inProgress,
    priority: ProjectPriority.urgent,
  ),
  Project(
    id: 'p-003',
    name: 'project-handbook',
    title: '量潮项目管理手册',
    description: '编写项目、项目集、项目组合的使用规范与操作手册，支撑团队日常管理实践。',
    createdAt: DateTime(2025, 3, 2),
    updatedAt: DateTime(2026, 7, 20),
    type: ProjectType.basic,
    hierarchy: 1,
    status: ProjectStatus.delivering,
    priority: ProjectPriority.middle,
  ),
  Project(
    id: 'p-004',
    name: 'learning-platform',
    title: '量潮学习平台',
    description: '面向组织内部的学习与培训平台，支持课程、考试、学分等能力。',
    createdAt: DateTime(2026, 2, 14),
    updatedAt: DateTime(2026, 8, 5),
    type: ProjectType.basic,
    hierarchy: 1,
    status: ProjectStatus.evaluating,
    priority: ProjectPriority.middle,
  ),
  Project(
    id: 'p-005',
    name: 'portfolio-2026',
    title: '2026年度重点投入项目组合',
    description: '统筹 2026 年度重点项目的资源分配与目标对齐，确保战略落地。',
    createdAt: DateTime(2025, 11, 1),
    updatedAt: DateTime(2026, 6, 30),
    type: ProjectType.projectPortfolio,
    hierarchy: 0,
    status: ProjectStatus.awaiting,
    priority: ProjectPriority.high,
  ),
];

/// 按名称查找项目
Project? findProjectByName(String name) {
  for (final Project project in mockProjects) {
    if (project.name == name) {
      return project;
    }
  }
  return null;
}

/// 需求列表（范围 · 收集需求）
final List<Requirement> mockRequirements = <Requirement>[
  const Requirement(
    code: 'REQ-001',
    title: '项目列表与详情查看',
    category: '功能需求',
    status: '已确认',
    description: '支持查看项目列表，并进入项目详情页查看基本信息与各管理领域内容。',
  ),
  const Requirement(
    code: 'REQ-002',
    title: '范围书编辑与评审',
    category: '功能需求',
    status: '已确认',
    description: '支持编辑项目范围书（目标、交付成果、边界），并按验收标准发起评审。',
  ),
  const Requirement(
    code: 'REQ-003',
    title: 'WBS 可视化管理',
    category: '功能需求',
    status: '已收集',
    description: '以树形图方式展示工作分解结构，支持逐级分解与查看。',
  ),
  const Requirement(
    code: 'REQ-004',
    title: '页面响应时间',
    category: '非功能需求',
    status: '已收集',
    description: '常规页面响应时间不超过 3 秒。',
  ),
];

/// WBS 节点（范围 · 创建WBS）
final List<WbsNode> mockWbs = <WbsNode>[
  const WbsNode(id: 'w-1', code: '1', title: '项目管理云'),
  const WbsNode(id: 'w-1-1', code: '1.1', title: '立项与规划', parentId: 'w-1'),
  const WbsNode(id: 'w-1-2', code: '1.2', title: '需求与设计', parentId: 'w-1'),
  const WbsNode(id: 'w-1-3', code: '1.3', title: '开发实现', parentId: 'w-1'),
  const WbsNode(id: 'w-1-4', code: '1.4', title: '测试验收', parentId: 'w-1'),
  const WbsNode(id: 'w-1-5', code: '1.5', title: '部署交付', parentId: 'w-1'),
  const WbsNode(id: 'w-1-2-1', code: '1.2.1', title: '范围书', parentId: 'w-1-2'),
  const WbsNode(id: 'w-1-2-2', code: '1.2.2', title: '原型设计', parentId: 'w-1-2'),
  const WbsNode(
      id: 'w-1-3-1', code: '1.3.1', title: '项目管理模块', parentId: 'w-1-3'),
  const WbsNode(
      id: 'w-1-3-2', code: '1.3.2', title: '范围管理模块', parentId: 'w-1-3'),
];

/// 范围变更申请（范围 · 控制范围）
final List<ScopeChange> mockScopeChanges = <ScopeChange>[
  const ScopeChange(
    code: 'SC-001',
    title: '增加项目集层级可视化',
    reason: '管理评审提出：需要直观展示项目集的层级关系，以便做更精准的层次关系可视化。',
    status: '待评审',
  ),
  const ScopeChange(
    code: 'SC-002',
    title: '移除公告模块',
    reason: '公告能力由学习平台承载，避免重复建设，缩减本期范围。',
    status: '已批准',
  ),
  const ScopeChange(
    code: 'SC-003',
    title: '增加移动端适配',
    reason: '业务方提出移动端访问需求，需评估影响范围与工期。',
    status: '已拒绝',
  ),
];

/// 里程碑（进度）
class Milestone {
  const Milestone(
      {required this.title, required this.date, required this.status});

  final String title;
  final DateTime date;
  final String status;
}

final List<Milestone> mockMilestones = <Milestone>[
  Milestone(title: '立项评审通过', date: _d1, status: '已完成'),
  Milestone(title: '范围书评审通过', date: _d2, status: '已完成'),
  Milestone(title: '原型评审通过', date: _d3, status: '进行中'),
  Milestone(title: '核心模块上线', date: _d4, status: '未开始'),
  Milestone(title: '项目验收交付', date: _d5, status: '未开始'),
];

final DateTime _d1 = DateTime(2026, 1, 15);
final DateTime _d2 = DateTime(2026, 3, 20);
final DateTime _d3 = DateTime(2026, 6, 30);
final DateTime _d4 = DateTime(2026, 10, 31);
final DateTime _d5 = DateTime(2026, 12, 25);

/// 成本项（成本）
class CostItem {
  const CostItem(
      {required this.title, required this.budget, required this.spent});

  final String title;
  final double budget;
  final double spent;
}

final List<CostItem> mockCostItems = <CostItem>[
  const CostItem(title: '人力成本', budget: 480000, spent: 356000),
  const CostItem(title: '基础设施', budget: 60000, spent: 42000),
  const CostItem(title: '第三方服务', budget: 40000, spent: 8000),
  const CostItem(title: '差旅与培训', budget: 20000, spent: 15000),
];

/// 质量指标（质量）
class QualityMetric {
  const QualityMetric(
      {required this.title, required this.target, required this.current});

  final String title;
  final String target;
  final String current;
}

final List<QualityMetric> mockQualityMetrics = <QualityMetric>[
  const QualityMetric(title: '需求覆盖率', target: '100%', current: '96%'),
  const QualityMetric(
      title: '缺陷密度', target: '≤ 1.0 个/KLOC', current: '0.8 个/KLOC'),
  const QualityMetric(title: '测试用例通过率', target: '≥ 98%', current: '99.2%'),
  const QualityMetric(title: '页面响应时间', target: '≤ 3s', current: '1.8s'),
];

/// 团队成员（资源）
class TeamMember {
  const TeamMember(
      {required this.name, required this.role, required this.workload});

  final String name;
  final String role;
  final String workload;
}

final List<TeamMember> mockTeamMembers = <TeamMember>[
  const TeamMember(name: '张三', role: '项目经理', workload: '100%'),
  const TeamMember(name: '李四', role: '产品经理', workload: '80%'),
  const TeamMember(name: '王五', role: '架构师', workload: '50%'),
  const TeamMember(name: '赵六', role: '开发工程师', workload: '100%'),
  const TeamMember(name: '钱七', role: '测试工程师', workload: '60%'),
];

/// 沟通计划（沟通）
class Communication {
  const Communication(
      {required this.name, required this.frequency, required this.audience});

  final String name;
  final String frequency;
  final String audience;
}

final List<Communication> mockCommunications = <Communication>[
  const Communication(name: '项目周会', frequency: '每周一', audience: '项目团队'),
  const Communication(name: '管理评审', frequency: '每月', audience: '管理层'),
  const Communication(name: '站会', frequency: '每日', audience: '开发小组'),
  const Communication(name: '发布公告', frequency: '按需', audience: '全体成员'),
];

/// 风险登记册（风险）
class Risk {
  const Risk(
      {required this.title,
      required this.probability,
      required this.impact,
      required this.response});

  final String title;
  final String probability;
  final String impact;
  final String response;
}

final List<Risk> mockRisks = <Risk>[
  const Risk(
      title: '关键开发人员离职',
      probability: '中',
      impact: '高',
      response: '储备人才池，交叉评审关键代码'),
  const Risk(
      title: '需求蔓延', probability: '高', impact: '中', response: '严格执行范围变更控制流程'),
  const Risk(
      title: '第三方服务交付延期',
      probability: '中',
      impact: '中',
      response: '提前采购，预留缓冲工期'),
  const Risk(
      title: '数据安全合规风险',
      probability: '低',
      impact: '高',
      response: '引入安全评审与合规检查'),
];

/// 采购项（采购）
class Procurement {
  const Procurement(
      {required this.title, required this.supplier, required this.status});

  final String title;
  final String supplier;
  final String status;
}

final List<Procurement> mockProcurements = <Procurement>[
  const Procurement(title: '云服务器资源', supplier: '云服务商', status: '已签约'),
  const Procurement(title: '短信验证码服务', supplier: '通信服务商', status: '询价中'),
  const Procurement(title: 'UI 设计外包', supplier: '设计工作室', status: '评估中'),
];

/// 人员
class Stakeholder {
  const Stakeholder(
      {required this.name, required this.role, required this.participation});

  final String name;
  final String role;
  final String participation;
}

final List<Stakeholder> mockStakeholders = <Stakeholder>[
  const Stakeholder(name: '刘总', role: '出资人', participation: '高'),
  const Stakeholder(name: '陈经理', role: '业务负责人', participation: '高'),
  const Stakeholder(name: '孙主任', role: '质量负责人', participation: '中'),
  const Stakeholder(name: '周同学', role: '最终用户代表', participation: '低'),
];
