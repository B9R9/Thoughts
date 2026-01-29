import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../l10n/onboarding.dart';

import 'package:Thought/screens/pincode_screen.dart';
import 'package:Thought/screens/lock_screen.dart';
import 'package:Thought/screens/settings_page.dart';
import 'package:Thought/services/hive_service.dart';

class OnboardingPage extends StatefulWidget {
  final Widget child;
  final bool isFromSettings;
  const OnboardingPage({
    super.key,
    required this.child,
    this.isFromSettings = false,
  });

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final _secureStorage = const FlutterSecureStorage();

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: HiveService.settings.listenable(),
      builder: (context, Box settingsBox, _) {
        final languageCode =
            settingsBox.get('language', defaultValue: 'en') as String;

        return Scaffold(
          backgroundColor: const Color(0xFF121212),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 40),
                  // Titre
                  Text(
                    OnboardingLocalization.welcome(languageCode),
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 40),
                  // Instructions
                  _buildInstructionItem(
                    icon: Icons.lock,
                    text: OnboardingLocalization.defaultPinSetup(languageCode),
                  ),
                  const SizedBox(height: 20),
                  _buildInstructionItem(
                    icon: Icons.touch_app,
                    text: OnboardingLocalization.clickToPreview(languageCode),
                  ),
                  const SizedBox(height: 20),
                  _buildInstructionItem(
                    icon: Icons.arrow_back,
                    text: OnboardingLocalization.swipeLeftToDelete(
                      languageCode,
                    ),
                  ),
                  const SizedBox(height: 20),
                  _buildInstructionItem(
                    icon: Icons.arrow_forward,
                    text: OnboardingLocalization.swipeRightToSave(languageCode),
                  ),
                  const SizedBox(height: 20),
                  _buildInstructionItem(
                    icon: Icons.arrow_upward,
                    text: OnboardingLocalization.swipeUpForList(languageCode),
                  ),
                  const SizedBox(height: 20),
                  _buildInstructionItem(
                    icon: Icons.arrow_downward,
                    text: OnboardingLocalization.closeBottomSheet(languageCode),
                  ),
                  const Spacer(),
                  // Bouton
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (context.mounted) {
                          if (widget.isFromSettings) {
                            Navigator.of(context).pop();
                            return;
                          }

                          await HiveService.settings.put(
                            'onboarding_seen',
                            true,
                          );
                          final pinCode = await _secureStorage.read(
                            key: 'pin_code',
                          );
                          final lockScreen = LockScreen(child: widget.child);

                          if (pinCode == null || pinCode.isEmpty) {
                            // Aller vers la configuration du PIN, puis lock screen
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (_) => PinCodePage(
                                  isSetup: true,
                                  child: lockScreen,
                                ),
                              ),
                            );
                          } else {
                            // Quitter l'onboarding vers l'écran de verrouillage
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(builder: (_) => SettingsPage()),
                            );
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        OnboardingLocalization.getStarted(languageCode),
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildInstructionItem({required IconData icon, required String text}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: Colors.teal, size: 24),
        const SizedBox(width: 16),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.white70,
              height: 1.5,
            ),
          ),
        ),
      ],
    );
  }
}
