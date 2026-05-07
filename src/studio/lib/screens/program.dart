/// 项目集页面

/*
import 'package:flutter/material.dart';
import 'package:graphview/graphview.dart';


/// 项目集页面
class ProgramScreen extends StatelessWidget {
  const ProgramScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // 创建Graph
    final graph = Graph()..isTree = true;
    // 创建Node
    final Node rootNode = Node.Id('quanttide');
    final Node qtclassNode = Node.Id('qtclass');
    final Node qtservicesNode = Node.Id('qtservices');
    // Node到Graph
    graph.addEdge(rootNode, qtclassNode);
    graph.addEdge(rootNode, qtservicesNode);
    return Scaffold(
      body: ProgramGraphWidget(graph: graph),
    );
  }
}


/// 项目集图组件
class ProgramGraphWidget extends StatelessWidget {
  final Graph graph;

  const ProgramGraphWidget({
    super.key,
    required this.graph
  });

  @override
  Widget build(BuildContext context) {
    // 算法配置
    final BuchheimWalkerConfiguration config = BuchheimWalkerConfiguration();
    config
      ..siblingSeparation = (100)
      ..levelSeparation = (150)
      ..subtreeSeparation = (150)
      // 方向，设置为从左到右。
      ..orientation = (BuchheimWalkerConfiguration.ORIENTATION_LEFT_RIGHT);
    // 算法
    final BuchheimWalkerAlgorithm algo = BuchheimWalkerAlgorithm(config, TreeEdgeRenderer(config));
    // 渲染
    return InteractiveViewer(
        constrained: false,
        boundaryMargin: const EdgeInsets.all(100),
        minScale: 0.01,
        maxScale: 5.6,
        child: GraphView(
          graph: graph,
          algorithm: algo,
          paint: Paint()
            ..color = Colors.green
            ..strokeWidth = 1
            ..style = PaintingStyle.stroke,
          builder: (Node node) {
            return ProgramNodeWidget(node: node);
          },
        )
    );
  }
}


/// 项目集节点组件
class ProgramNodeWidget extends StatelessWidget {
  final Node node;

  const ProgramNodeWidget({
    super.key,
    required this.node,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
      },
      child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            boxShadow: [
              BoxShadow(color: Colors.blue[100]!, spreadRadius: 1),
            ],
          ),
          child: Text(node.key?.value as String)),
    );
  }
}
 */
