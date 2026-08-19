import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutterui/app/core/service_locators.dart';
import 'package:flutterui/app/presentation/home/widgets/hero_section.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterui/components/data/logic/component/component_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

void main() {
  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    HydratedBloc.storage = await HydratedStorage.build(
      storageDirectory: HydratedStorageDirectory(
        Directory.systemTemp.createTempSync('hb').path,
      ),
    );
    await ServiceLocators.register();
  });

  Future<void> renderAt(WidgetTester tester, Size size) async {
    tester.view.physicalSize = size;
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);
    await tester.pumpWidget(
      BlocProvider<ComponentBloc>.value(
        value: getIt.get<ComponentBloc>(),
        child: MaterialApp(
          home: Scaffold(
            body: SingleChildScrollView(
              child: HeroSection(onBrowserAll: () {}),
            ),
          ),
        ),
      ),
    );
    await tester.pump(const Duration(milliseconds: 500));
    await tester.pump(const Duration(seconds: 3));
  }

  testWidgets('desktop', (t) async => renderAt(t, const Size(1440, 900)));
  testWidgets('laptop', (t) async => renderAt(t, const Size(1100, 800)));
  testWidgets('tablet', (t) async => renderAt(t, const Size(820, 1000)));
  testWidgets('mobile', (t) async => renderAt(t, const Size(390, 844)));
}
