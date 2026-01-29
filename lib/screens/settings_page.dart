import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:Thought/screens/onboarding_page.dart';
import 'package:Thought/screens/pincode_screen.dart';
import 'package:Thought/main.dart';
import 'package:Thought/screens/lock_screen.dart';
import 'package:Thought/services/hive_service.dart';

import '../l10n/settings.dart';
import '../l10n/strings.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: HiveService.settings.listenable(),
      builder: (context, Box settingsBox, _) {
        final languageCode =
            settingsBox.get('language', defaultValue: 'en') as String;

        return Scaffold(
          appBar: AppBar(
            title: Text(SettingsLocalization.settingsPageTitle(languageCode)),
          ),
          body: ListView(
            children: const [
              DisplayOnboardingTile(),
              Divider(),
              SetLanguageTile(),
              Divider(),
              ResetThoughtsTile(),
              Divider(),
              ManagePin(),
              Divider(),
              FeedbackTile(),
            ],
          ),
        );
      },
    );
  }
}

class DisplayOnboardingTile extends StatelessWidget {
  const DisplayOnboardingTile({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: HiveService.settings.listenable(),
      builder: (context, Box settingsBox, _) {
        final languageCode =
            settingsBox.get('language', defaultValue: 'en') as String;

        return ListTile(
          leading: const Icon(Icons.info),
          title: Text(
            DisplayOnboardingLocalization.displayOnboarding(languageCode),
          ),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => OnboardingPage(
                  child: MyHomePage(title: Strings.appTitle(languageCode)),
                  isFromSettings: true,
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class FeedbackTile extends StatelessWidget {
  const FeedbackTile({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: HiveService.settings.listenable(),
      builder: (context, Box settingsBox, _) {
        final languageCode =
            settingsBox.get('language', defaultValue: 'en') as String;

        return ListTile(
          leading: const Icon(Icons.feedback),
          title: Text(FeedbackLocalization.feedback(languageCode)),
          onTap: () {
            // Logique d'envoi de feedback ici
          },
        );
      },
    );
  }
}

class ManagePin extends StatelessWidget {
  const ManagePin({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: HiveService.settings.listenable(),
      builder: (context, Box settingsBox, _) {
        final languageCode =
            settingsBox.get('language', defaultValue: 'en') as String;

        return Column(
          children: [
            ListTile(
              leading: const Icon(Icons.lock),
              title: Text(ManagePinLocalization.managePin(languageCode)),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8.0,
              ),
              child: Column(
                children: [
                  // Bouton Changer le PIN
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => PinCodePage(
                              isSetup: false,
                              isChange: true,
                              child:
                                  MyHomePage(title: Strings.appTitle(languageCode)),
                            ),
                          ),
                        );
                      },
                      icon: const Icon(Icons.edit),
                      label: Text(
                        ManagePinLocalization.changePin(languageCode),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  // Bouton Réinitialiser
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text(
                              ManagePinLocalization.resetConfirmTitle(
                                languageCode,
                              ),
                            ),
                            content: Text(
                              ManagePinLocalization.resetConfirmMessage(
                                languageCode,
                              ),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.of(context).pop(),
                                child: Text(
                                  ManagePinLocalization.cancel(languageCode),
                                ),
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red,
                                ),
                                onPressed: () async {
                                  final secureStorage =
                                      const FlutterSecureStorage();
                                  final settingsBox = HiveService.settings;

                                  await secureStorage.delete(key: 'pin_code');
                                  await HiveService.clearThoughts();
                                  await settingsBox.put('pin_enabled', false);
                                  if (context.mounted) {
                                    Navigator.of(context).pop();
                                    Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                        builder: (_) => PinCodePage(
                                          isSetup: true,
                                          child: LockScreen(
                                            child: MyHomePage(
                                              title: Strings.appTitle(
                                                languageCode,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          ManagePinLocalization
                                              .resetSuccessMessage(
                                                languageCode,
                                              ),
                                        ),
                                      ),
                                    );
                                  }
                                },
                                child: Text(
                                  ManagePinLocalization.resetConfirm(
                                    languageCode,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      icon: const Icon(Icons.restart_alt),
                      label: Text(
                        ManagePinLocalization.resetPin(languageCode),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

class ResetThoughtsTile extends StatelessWidget {
  const ResetThoughtsTile({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: HiveService.settings.listenable(),
      builder: (context, Box settingsBox, _) {
        final languageCode =
            settingsBox.get('language', defaultValue: 'en') as String;

        return ListTile(
          leading: const Icon(Icons.delete_forever, color: Colors.red),
          title: Text(ResetThoughtsLocalization.resetThoughts(languageCode)),
          onTap: () {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text(
                  ResetThoughtsLocalization.resetThoughtsConfirmationTitle(
                    languageCode,
                  ),
                ),
                content: Text(
                  ResetThoughtsLocalization.resetThoughtsConfirmationMessage(
                    languageCode,
                  ),
                ),
                actions: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: Text(
                          ResetThoughtsLocalization.cancel(languageCode),
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                        ),
                        onPressed: () async {
                          await HiveService.clearThoughts();
                          if (context.mounted) {
                            Navigator.of(context).pop();
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  ResetThoughtsLocalization.successMessage(
                                    languageCode,
                                  ),
                                ),
                              ),
                            );
                          }
                        },
                        child: Text(
                          ResetThoughtsLocalization.resetThoughtsButton(
                            languageCode,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

class SetLanguageTile extends StatelessWidget {
  const SetLanguageTile({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: HiveService.settings.listenable(),
      builder: (context, Box settingsBox, _) {
        final languageCode =
            settingsBox.get('language', defaultValue: 'en') as String;

        return ListTile(
          leading: const Icon(Icons.language),
          title: Text(SetLanguageLocalization.setLanguage(languageCode)),
          onTap: () {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text(
                  SetLanguageLocalization.chooseLanguage(languageCode),
                ),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildLanguageTile(context, '🇬🇧', 'English', 'en'),
                    _buildLanguageTile(context, '🇫🇮', 'Suomi', 'fi'),
                    _buildLanguageTile(context, '🇸🇪', 'Svenska', 'sv'),
                    _buildLanguageTile(context, '🇫🇷', 'Français', 'fr'),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildLanguageTile(
    BuildContext context,
    String flag,
    String name,
    String code,
  ) {
    return ListTile(
      leading: Text(flag, style: const TextStyle(fontSize: 24)),
      title: Text(name),
      onTap: () async {
        final box = HiveService.settings;
        await box.put('language', code);
        if (context.mounted) {
          Navigator.of(context).pop();
        }
      },
    );
  }
}
