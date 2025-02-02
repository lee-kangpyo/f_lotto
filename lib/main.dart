import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:lotto/models/FilterNumbers.dart';
import 'package:lotto/models/currentGenerated.dart';
import 'package:lotto/models/lotto.dart';
import 'package:lotto/provider/count_provider.dart';
import 'package:lotto/screens/CheckMyLotto.dart';
import 'package:lotto/screens/FavoriteLotto.dart';
import 'package:lotto/screens/GenerateLotto.dart';
import 'package:lotto/screens/SettingsScreen.dart';
import 'package:lotto/theme.dart';
import 'package:lotto/util/adMobService.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  // FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  MobileAds.instance.initialize();
  await Hive.initFlutter();
  Hive.registerAdapter(LottoAdapter());
  Hive.registerAdapter(FilterNumbersAdapter());
  Hive.registerAdapter(CurrentGeneratedAdapter());
  await Hive.openBox<Lotto>("lottos");
  await Hive.openBox<FilterNumbers>("filterNumbers");
  await Hive.openBox<CurrentGenerated>("currentGenerated");
  await dotenv.load(fileName: ".env");


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
      debugShowCheckedModeBanner: false,
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
  BannerAd? _bannerAd;
  int _selectScreen = 0;

  @override
  void initState() {
    super.initState();
    _createBannerAd(); //추가
  }
  //배너 광고 생성
  void _createBannerAd() {
    _bannerAd = BannerAd(
      size: AdSize.fullBanner, //배너 사이즈
      adUnitId: AdMobService.bannerAdUnitId!, //광고ID 등록
      listener: AdMobService.bannerAdListener, //리스너 등록
      request: const AdRequest(),
    )..load();
  }

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
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          (_bannerAd == null)?
          const SizedBox.shrink():SizedBox(
            width: MediaQuery.of(context).size.width,
            height: _bannerAd!.size.height.toDouble(),
            child: AdWidget(
              ad: _bannerAd!,
            ),
          ),
          BottomNavigationBar(
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
        ],
      ),
    );
  }
}