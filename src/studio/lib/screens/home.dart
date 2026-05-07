/// 首页

import 'package:flutter/material.dart';
import 'package:flutter_side_menu/flutter_side_menu.dart';


/// 导航栏单元模型
class QuantTideDestinationModel {
  const QuantTideDestinationModel(this.label, this.icon, this.selectedIcon);

  final String label;
  final Widget icon;
  final Widget selectedIcon;
}

const List<QuantTideDestinationModel> destinations = <QuantTideDestinationModel>[
  QuantTideDestinationModel(
      '事项', Icon(Icons.widgets_outlined), Icon(Icons.widgets)),
  QuantTideDestinationModel(
      '资源', Icon(Icons.format_paint_outlined), Icon(Icons.format_paint)),
  QuantTideDestinationModel(
      '讨论', Icon(Icons.text_snippet_outlined), Icon(Icons.text_snippet)),
  QuantTideDestinationModel(
      '会议', Icon(Icons.invert_colors_on_outlined), Icon(Icons.opacity)),
  QuantTideDestinationModel(
      '公告', Icon(Icons.notifications_outlined), Icon(Icons.notifications_off)),
];


/// 首页
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int screenIndex = 0;

  void handleScreenChanged(int selectedScreen) {
    setState(() {
      screenIndex = selectedScreen;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          SideMenu(
            builder: (data) => SideMenuData(
              header: const Text('量潮科技'),
              items: [
                SideMenuItemDataTile(
                  isSelected: true,
                  onTap: () {},
                  title: '事项',
                  icon: const Icon(Icons.widgets_outlined),
                ),
                SideMenuItemDataTile(
                  isSelected: false,
                  onTap: () {},
                  title: '资源',
                  icon: const Icon(Icons.format_paint_outlined),
                ),
                SideMenuItemDataTile(
                  isSelected: false,
                  onTap: () {},
                  title: '讨论',
                  icon: const Icon(Icons.text_snippet_outlined),
                ),
                SideMenuItemDataTile(
                  isSelected: false,
                  onTap: () {},
                  title: '会议',
                  icon: const Icon(Icons.invert_colors_on_outlined),
                ),
                SideMenuItemDataTile(
                  isSelected: false,
                  onTap: () {},
                  title: '公告',
                  icon: const Icon(Icons.notifications_outlined),
                ),
              ],
              footer: const Text('量潮项目管理'),
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.white,
              child: const Center(
                child: Text(
                  'body',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
