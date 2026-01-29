import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../l10n/strings.dart';
import '../services/hive_service.dart';

class LockScreen extends StatefulWidget {
  final Widget child;
  const LockScreen({super.key, required this.child});

  @override
  State<LockScreen> createState() => _LockScreenState();
}

class _LockScreenState extends State<LockScreen> {
  final LocalAuthentication auth = LocalAuthentication();
  final _secureStorage = const FlutterSecureStorage();
  bool _authenticated = false;
  final TextEditingController _pinController = TextEditingController();
  late Box settingsBox;

  @override
  void initState() {
    super.initState();
    settingsBox = HiveService.settings;
    _checkAuth();
  }

  Future<void> _checkAuth() async {
    final languageCode =
        settingsBox.get('language', defaultValue: 'en') as String;
    bool canCheck =
        await auth.canCheckBiometrics || await auth.isDeviceSupported();

    if (canCheck) {
      bool authenticated = await auth.authenticate(
        localizedReason: Strings.unlockYourThoughts(languageCode),
        options: const AuthenticationOptions(
          biometricOnly: true,
          stickyAuth: true,
        ),
      );

      if (authenticated) {
        setState(() => _authenticated = true);
        return;
      }
    }

    // Biometrie indispo ou échouée -> fallback PIN
    if (!mounted) return;
    setState(() => _authenticated = false);
  }

  Future<void> _checkPin(String languageCode) async {
    final savedPin = await _secureStorage.read(key: 'pin_code');
    if (savedPin != null && _pinController.text == savedPin) {
      setState(() => _authenticated = true);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(Strings.pinIncorrect(languageCode))),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_authenticated) return widget.child;

    return ValueListenableBuilder(
      valueListenable: settingsBox.listenable(),
      builder: (context, Box box, _) {
        final languageCode = box.get('language', defaultValue: 'en') as String;

        return Scaffold(
          backgroundColor: Colors.black,
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    Strings.enterPin(languageCode),
                    style: const TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _pinController,
                    keyboardType: TextInputType.number,
                    obscureText: true,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: Strings.pinHint(languageCode),
                      hintStyle: TextStyle(color: Colors.grey.shade500),
                      filled: true,
                      fillColor: const Color(0xFF1E1E1E),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                    ),
                    onSubmitted: (_) => _checkPin(languageCode),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => _checkPin(languageCode),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                    ),
                    child: Text(Strings.unlockWithPin(languageCode)),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _pinController.dispose();
    super.dispose();
  }
}
