import 'package:budget_tracker/view_models/shared_preferences_provider.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'theme_provider.g.dart';

@riverpod
class Theme extends _$Theme {
    @override
    ThemeData build() {
        return getTheme();
    }

    ThemeData getTheme(){
        final prefs = ref.watch(sharedPreferencesProvider);
        final isLight = prefs.getBool('isLight') ?? true;
        return isLight ? ThemeData.light(useMaterial3: true) : ThemeData.dark(useMaterial3: true);
    }

    Future<void> changeTheme() async {
        final prefs = ref.watch(sharedPreferencesProvider);
        state = state == ThemeData.light(useMaterial3: true) ? ThemeData.dark(useMaterial3: true) : ThemeData.light(useMaterial3: true);
        if (state == ThemeData.light(useMaterial3: true)){
            await prefs.setBool('isLight', true);
        }else{
            await prefs.setBool('isLight', false);
        }
    }
}