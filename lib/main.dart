import 'package:flutter/material.dart';
import 'package:lotto/models/FilterNumbers.dart';
import 'package:lotto/models/currentGenerated.dart';
import 'package:lotto/models/lotto.dart';
import 'package:lotto/provider/count_provider.dart';
import 'package:lotto/screens/CheckMyLotto.dart';
import 'package:lotto/screens/FavoriteLotto.dart';
import 'package:lotto/screens/GenerateLotto.dart';
import 'package:lotto/screens/SettingsScreen.dart';
import 'package:lotto/theme.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(LottoAdapter());
  Hive.registerAdapter(FilterNumbersAdapter());
  Hive.registerAdapter(CurrentGeneratedAdapter());
  await Hive.openBox<Lotto>("lottos");
  await Hive.openBox<FilterNumbers>("filterNumbers");
  await Hive.openBox<CurrentGenerated>("currentGenerated");


  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => CountProvider()),
    ],
    child: Builder(builder: (context) {
      return const MyApp();
    },),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '로또 번호 생성기',
      theme: myTheme,
      home: const MyHomePage(title: '로또 번호 생성'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _TapContainer();
}

class _TapContainer extends State<MyHomePage> {
  int _selectScreen = 0;
  final List<Widget> _screens = [
    const GenerateLotto(),
    const FavoratieLotto(),
    const CheckMyLotto(),
    const SettingsScreen(),
    const Text("floatingButton"),
  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectScreen = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      //   title: Text(widget.title),
      // ),

      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {print("이동");},
      //   elevation: 0,
      //   child: const Icon(Icons.edit),
      // ),
      // //FAB의 위치 조절
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: SafeArea(
        child: Center(
          child: _screens.elementAt(_selectScreen),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              icon: _selectScreen == 0? const Icon(Icons.home_sharp,): const Icon(Icons.home_outlined,),
              label: '홈'
          ),
          BottomNavigationBarItem(
              icon: _selectScreen == 1? const Icon(Icons.star):  const Icon(Icons.star_border),
              label: '즐겨찾기',
          ),
          BottomNavigationBarItem(
              icon: _selectScreen == 2? const Icon(Icons.qr_code_scanner): const Icon(Icons.qr_code_scanner),
              label: '당첨확인'
          ),
          BottomNavigationBarItem(
              icon: _selectScreen == 3? const Icon(Icons.menu): const Icon(Icons.menu),
              label: '설정'
          ),
        ],
        currentIndex: _selectScreen,
        selectedItemColor: Theme.of(context).colorScheme.inversePrimary,
        onTap: _onItemTapped,
        //showSelectedLabels: true,
        //showUnselectedLabels: true,
        //selectedLabelStyle: TextStyle(color: Theme.of(context).colorScheme.inversePrimary),
        //unselectedLabelStyle: TextStyle(color: Theme.of(context).colorScheme.inversePrimary),
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
