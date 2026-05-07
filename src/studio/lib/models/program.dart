/// 项目集模型

import 'package:graphview/graphview.dart';
import 'package:freezed_annotation/freezed_annotation.dart';


/// 项目集节点
///
/// TODO: 使用freezed改造
// @Freezed()
class ProgramNode extends Node {
  /// 项目集ID
  String id;
  /// 项目集标题
  String title;
  /// 项目集描述
  String? description;

  ProgramNode({
    required this.id,
    required this.title,
    this.description
  }) : super.Id(id);
}


/// 项目集图
///
/// TODO: 使用Freezed改造
///
// @Freezed()
class ProgramGraph extends Graph {
  ProgramGraph();
}
