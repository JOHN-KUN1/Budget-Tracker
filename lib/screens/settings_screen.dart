import 'package:budget_tracker/view_models/theme_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:settings_ui/settings_ui.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  List<String> currencies = ['USD', 'NGN'];
  String currency = 'USD';

  @override
  Widget build(BuildContext context) {
    bool isDark =
        ref.watch(themeProvider) == ThemeData.light(useMaterial3: true)
        ? false
        : true;
    return SettingsList(
      contentPadding: EdgeInsets.symmetric(horizontal: 7),
      platform: DevicePlatform.android,
      lightTheme: const SettingsThemeData(
        settingsListBackground: Colors.white,
      ),
      // darkTheme: const SettingsThemeData(
      //   settingsListBackground: Colors.black,
      //   settingsSectionBackground: Color.fromARGB(255, 52, 51, 51),
      // ),
      sections: [
        SettingsSection(
          title: Text(
            'APPEARANCE',
            style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey),
          ),
          tiles: [
            SettingsTile.switchTile(
              initialValue: isDark,
              leading: const Icon(Icons.color_lens_outlined),
              title: Text(
                'Change Theme',
                style: GoogleFonts.poppins(
                  color: isDark ? Colors.white : Colors.black,
                ),
              ),
              onToggle: (value) {
                ref.read(themeProvider.notifier).changeTheme();
                setState(() {
                  isDark = value;
                });
              },
            ),
          ],
        ),
        SettingsSection(
          title: Text(
            'CURRENCY',
            style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey),
          ),
          tiles: [
            SettingsTile(
              leading: Icon(Icons.money),
              title: Text(
                'Currency',
                style: GoogleFonts.poppins(
                  color: isDark ? Colors.white : Colors.black,
                ),
              ),
              trailing: DropdownButton(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                icon: const Icon(Icons.keyboard_arrow_down),
                value: currency,
                hint: Text(
                  'Currency',
                  style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                items: [
                  for (final cur in currencies)
                    DropdownMenuItem(
                      value: cur,
                      child: Text(
                        cur.substring(0, 1).toUpperCase() + cur.substring(1),
                      ),
                    ),
                ],
                onChanged: (value) {
                  setState(() {
                    currency = value!;
                  });
                },
              ),
            ),
          ],
        ),
        SettingsSection(
          title: Text(
            'ABOUT',
            style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey),
          ),
          tiles: [
            SettingsTile(
              leading: Icon(Icons.phone_android),
              title: Text(
                'Version',
                style: GoogleFonts.poppins(
                  color: isDark ? Colors.white : Colors.black,
                ),
              ),
              trailing: Text(
                '1.0.0',
                style: GoogleFonts.poppins(color: Colors.grey),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
