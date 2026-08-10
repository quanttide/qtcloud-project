/// 项目模型
///
/// 字段定义遵循《项目规范》：
/// https://github.com/quanttide/quanttide-project/blob/main/docs/specification/projects/README.md

/// 项目类型
///
/// 定义见《项目类型规范》。
enum ProjectType {
  basic('default', '项目'),
  program('program', '项目集'),
  projectPortfolio('project_portfolio', '项目组合');

  const ProjectType(this.value, this.label);

  /// 字段值
  final String value;

  /// 显示名称
  final String label;
}

/// 项目状态（生命周期）
///
/// 定义见《项目生命周期规范》。
enum ProjectStatus {
  drafting('drafting', '起草中'),
  evaluating('evaluating', '评估中'),
  awaiting('awaiting', '等待开始'),
  inProgress('in_progress', '进行中'),
  delayed('delayed', '已延迟'),
  paused('paused', '已暂停'),
  reviewing('reviewing', '评审中'),
  delivering('delivering', '交付中'),
  summarizing('summarizing', '复盘中'),
  completed('completed', '已完成'),
  cancelled('cancelled', '已取消');

  const ProjectStatus(this.value, this.label);

  /// 字段值
  final String value;

  /// 显示名称
  final String label;
}

/// 项目优先级
///
/// 定义见《项目优先级规范》。
enum ProjectPriority {
  low('low', '低'),
  middle('middle', '中'),
  high('high', '高'),
  urgent('urgent', '紧急');

  const ProjectPriority(this.value, this.label);

  /// 字段值
  final String value;

  /// 显示名称
  final String label;
}

/// 项目
class Project {
  const Project({
    required this.id,
    required this.name,
    required this.title,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
    required this.type,
    required this.hierarchy,
    required this.status,
    required this.priority,
  });

  /// ID
  final String id;

  /// 名称（REST API 标识，`/projects/<name>`）
  final String name;

  /// 标题
  final String title;

  /// 描述
  final String description;

  /// 创建时间
  final DateTime createdAt;

  /// 更新时间
  final DateTime updatedAt;

  /// 类型
  final ProjectType type;

  /// 层级（数字越小层级越高，0 为根层级）
  final int hierarchy;

  /// 状态
  final ProjectStatus status;

  /// 优先级
  final ProjectPriority priority;
}
