// theme.dart
import 'package:flutter/material.dart';


final myTheme = ThemeData(
  fontFamily: 'SUIT',
  colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xff9294F9)),
  scaffoldBackgroundColor: const Color(0xffffffff), // Scafold 배경 색상
  useMaterial3: true,
  elevatedButtonTheme:ElevatedBtnStyle,
  textTheme:textStyle
);


final ElevatedBtnStyle = ElevatedButtonThemeData(
  style: ElevatedButton.styleFrom(
    backgroundColor: const Color(0xff1C6AE6),     // 버튼 배경 색상
    foregroundColor: Colors.white,                // 버튼 텍스트 색상
    textStyle: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16.0),  // 텍스트 스타일
    padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),    // 버튼 패딩
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20.0),  // 버튼 모서리 둥글기
    ),
  ),
);

const FONTWEIGHT_LIGHT = FontWeight.w300;
const FONTWEIGHT_REGULAR = FontWeight.w400;
const FONTWEIGHT_MEDIUM = FontWeight.w500;
const FONTWEIGHT_BOLD = FontWeight.bold;

const textStyle = TextTheme(
  displayLarge: TextStyle(
    fontFamily: "SUIT",
    fontSize: 57.0,
    fontWeight: FONTWEIGHT_REGULAR,
    letterSpacing:0,
    // height: 64
  ),
  displayMedium: TextStyle(
    fontFamily: "SUIT",
    fontSize: 45.0,
    fontWeight: FONTWEIGHT_REGULAR,
    letterSpacing:0,
    // height: 52
  ),
  displaySmall: TextStyle(
    fontFamily: "SUIT",
    fontSize: 36.0,
    fontWeight: FONTWEIGHT_REGULAR,
    letterSpacing: 0,
    // height: 44,
  ),
  headlineLarge: TextStyle(
    fontFamily: "SUIT",
    fontSize: 32.0,
    fontWeight: FONTWEIGHT_REGULAR,
    letterSpacing: 0,
    // height: 40
  ),
  headlineMedium: TextStyle(
    fontFamily: "SUIT",
    fontSize: 28.0,
    fontWeight: FONTWEIGHT_REGULAR,
    letterSpacing: 0,
    // height: 36
  ),
  headlineSmall:TextStyle(
    fontFamily: "SUIT",
    fontSize: 24.0,
    fontWeight: FONTWEIGHT_REGULAR,
    letterSpacing: 0.0,
    // height: 32
  ),
  titleLarge: TextStyle(
    fontFamily: "SUIT",
    fontSize: 22.0,
    fontWeight: FONTWEIGHT_MEDIUM,
    letterSpacing: 0,
    // height: 28
  ),
  titleMedium: TextStyle(
    fontFamily: "SUIT",
    fontSize: 16.0,
    fontWeight: FONTWEIGHT_MEDIUM,
    letterSpacing: 0.15,
    // height: 24
  ),
  titleSmall: TextStyle(
    fontFamily: "SUIT",
    fontSize: 14.0,
    fontWeight: FONTWEIGHT_MEDIUM,
    letterSpacing: 0.1,
    // height: 20,
  ),
  labelLarge: TextStyle(
    fontFamily: "SUIT",
    fontSize: 14.0,
    fontWeight: FONTWEIGHT_MEDIUM,
    letterSpacing: 0.1,
    // height: 20,
  ),
  labelMedium: TextStyle(
    fontFamily: "SUIT",
    fontSize: 12.0,
    fontWeight: FONTWEIGHT_MEDIUM,
    letterSpacing: 0.5,
    // height: 16,
  ),
  labelSmall: TextStyle(fontFamily: "SUIT",
    fontSize: 11.0,
    fontWeight: FONTWEIGHT_MEDIUM,
    letterSpacing: 0.5,
    // height: 16,
  ),
  bodyLarge:TextStyle(
    fontFamily: "SUIT",
    fontSize: 16.0,
    fontWeight: FONTWEIGHT_REGULAR,
    letterSpacing: 0.15,
    // height: 24
  ),
  bodyMedium: TextStyle(
    fontFamily: "SUIT",
    fontSize: 14.0,
    fontWeight: FONTWEIGHT_REGULAR,
    letterSpacing: 0.25,
    //height: 20
  ),
  bodySmall: TextStyle(
    fontFamily: "SUIT",
    fontSize: 12.0,
    fontWeight: FONTWEIGHT_REGULAR,
    letterSpacing: 0.4,
    //height: 16
  ),
);
