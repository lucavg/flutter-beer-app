import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:beer_app/di/injectable.dart';
import 'package:beer_app/navigator/main_navigator.dart';
import 'package:flutter_test/flutter_test.dart';

import '../di/test_injectable.dart';
import '../screen/seed.dart';
import '../util/test_util.dart';

void main() {
  setUp(() async => initTestInjectable());

  testWidgets('Test main navigator widget todo add', (tester) async {
    seedGlobalViewModel();
    seedAuthStorage();
    seedLocalStorage();

    final mainNavigator = MainNavigator(getIt.get());
    final testWidget = await TestUtil.loadScreen(tester, const SizedBox.shrink());
    await TestUtil.takeScreenshotForAllSizes(tester, testWidget, 'main_navigator_todo_add_screen_0_initial_screen');

    await tester.pumpAndSettle();
    await TestUtil.takeScreenshotForAllSizes(tester, testWidget, 'main_navigator_todo_add_screen_1');
    mainNavigator.goBack<void>();
    await tester.pumpAndSettle();
    await TestUtil.takeScreenshotForAllSizes(tester, testWidget, 'main_navigator_todo_add_screen_2_go_back');
  });
}
