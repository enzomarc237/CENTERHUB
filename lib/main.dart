import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:macos_ui/macos_ui.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MacosApp(
      title: 'macOS Web Browser',
      theme: MacosThemeData.light(),
      darkTheme: MacosThemeData.dark(),
      themeMode: ThemeMode.system,
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _pageIndex = 1;
  final _searchController = TextEditingController(text: 'en.wikipedia.org/wiki/Main_Page');

  @override
  Widget build(BuildContext context) {
    return MacosWindow(
      sidebar: Sidebar(
        minWidth: 250,
        builder: (context, scrollController) {
          return SidebarItems(
            currentIndex: _pageIndex,
            onChanged: (index) {
              setState(() => _pageIndex = index);
            },
            items: const [
              SidebarItem(
                leading: MacosIcon(CupertinoIcons.folder_badge_plus),
                label: Text('GitHub - where the world builds software'),
              ),
              SidebarItem(
                leading: MacosIcon(CupertinoIcons.globe),
                label: Text('Wikipedia'),
              ),
              SidebarItem(
                leading: MacosIcon(CupertinoIcons.pen),
                label: Text('Design Insights - A Personal Blog'),
              ),
            ],
          );
        },
        bottom: Column(
          children: [
            const SizedBox(
              height: 1,
              width: double.infinity,
              child: ColoredBox(
                color: Colors.grey,
              ),
            ),
            MacosListTile(
              leading: const MacosIcon(CupertinoIcons.add),
              title: const Text('New Tab'),
              onClick: () {},
            ),
            MacosListTile(
              leading: const MacosIcon(CupertinoIcons.settings),
              title: const Text('Settings'),
              onClick: () {},
            ),
          ],
        ),
      ),
      child: MacosScaffold(
        toolBar: ToolBar(
          title: const Text(''),
          leading: Row(
            children: [
              MacosIconButton(
                icon: const MacosIcon(CupertinoIcons.back),
                onPressed: () {},
              ),
              MacosIconButton(
                icon: const MacosIcon(CupertinoIcons.forward),
                onPressed: () {},
              ),
              MacosIconButton(
                icon: const MacosIcon(CupertinoIcons.refresh),
                onPressed: () {},
              ),
            ],
          ),
          actions: [
            CustomToolbarItem(
              inToolbarBuilder: (context) {
                return MacosTextField(
                  controller: _searchController,
                  prefix: const MacosIcon(CupertinoIcons.lock_fill),
                  suffix: MacosIconButton(
                    icon: const MacosIcon(CupertinoIcons.xmark_circle_fill),
                    onPressed: () {
                      _searchController.clear();
                    },
                  ),
                );
              },
            ),
            ToolBarIconButton(
              label: 'Extensions',
              icon: const MacosIcon(CupertinoIcons.square_grid_2x2),
              onPressed: () {},
              showLabel: false,
            ),
            ToolBarIconButton(
              label: 'More',
              icon: const MacosIcon(CupertinoIcons.ellipsis),
              onPressed: () {},
              showLabel: false,
            ),
          ],
        ),
        children: [
          ContentArea(
            builder: (context, scrollController) {
              return Image.network(
                'https://lh3.googleusercontent.com/aida-public/AB6AXuAPWvPaBpbCQuZVP10XjQVPbPXTWq1xpDgAhUyk_ZseXaLJoVqkweUpNLFOSCFOhXlPfCUk_bEdgdiKtuLHdivwzblCNtE_Jty7fXbNWJ2QRkXpJ-Fjo2JLuAmwv4l-9rl-4lXuEVEnjwjfO-wV-NgRUcFxQbiYTrQC4fqfP4IRr1fOZmPOtk2wa1V1usd4mcHbJDwWShWIjh30aFpjOLVaV6FtKv9MdkY4UfEa6npe_E8jv1Jsu-63T9QO6lBvoLQwKG69NUCy8Tjw',
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              );
            },
          ),
        ],
      ),
    );
  }
}
