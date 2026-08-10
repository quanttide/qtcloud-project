/// 范围管理模型
///
/// 参考《项目管理手册 · 项目范围管理》：
/// 收集需求、定义范围、创建工作分解结构、核实范围、控制范围。
library;

/// 需求
class Requirement {
  const Requirement({
    required this.code,
    required this.title,
    required this.category,
    required this.status,
    this.description,
  });

  /// 需求编号，如 `REQ-001`
  final String code;

  /// 需求标题
  final String title;

  /// 需求类别：功能需求 / 非功能需求
  final String category;

  /// 需求状态：已收集 / 已确认 / 已实现
  final String status;

  /// 需求描述
  final String? description;
}

/// 工作分解结构（WBS）节点
class WbsNode {
  const WbsNode({
    required this.id,
    required this.code,
    required this.title,
    this.parentId,
  });

  /// 节点ID
  final String id;

  /// 节点编码，如 `1.1`
  final String code;

  /// 节点标题
  final String title;

  /// 父节点ID，根节点为空
  final String? parentId;
}

/// 范围变更申请
class ScopeChange {
  const ScopeChange({
    required this.code,
    required this.title,
    required this.reason,
    required this.status,
  });

  /// 变更编号，如 `SC-001`
  final String code;

  /// 变更标题
  final String title;

  /// 变更原因
  final String reason;

  /// 变更状态：待评审 / 已批准 / 已拒绝
  final String status;
}
