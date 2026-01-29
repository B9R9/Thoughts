import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../services/hive_service.dart';
import '../l10n/pincode.dart';

class PinCodePage extends StatefulWidget {
  final bool isSetup;
  final bool isChange;
  final Widget child;

  const PinCodePage({
    super.key,
    required this.isSetup,
    this.isChange = false,
    required this.child,
  });

  @override
  State<PinCodePage> createState() => _PinCodePageState();
}

class _PinCodePageState extends State<PinCodePage> {
  final _secureStorage = const FlutterSecureStorage();
  final _oldPinController = TextEditingController();
  final _pinController = TextEditingController();
  final _confirmPinController = TextEditingController();
  String _errorMessage = '';

  @override
  void dispose() {
    _oldPinController.dispose();
    _pinController.dispose();
    _confirmPinController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final languageCode = HiveService.settings.get(
      'language',
      defaultValue: 'en',
    );

    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        backgroundColor: const Color(0xFF121212),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                _getTitle(languageCode),
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),

              // Champ ancien PIN (seulement en mode changement)
              if (widget.isChange) ...[
                TextField(
                  controller: _oldPinController,
                  obscureText: true,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(4),
                  ],
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    letterSpacing: 8,
                  ),
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    hintText: '••••',
                    hintStyle: TextStyle(
                      color: Colors.grey[600],
                      letterSpacing: 8,
                    ),
                    filled: true,
                    fillColor: Colors.grey[900],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(vertical: 20),
                  labelText: PinCodeLocalization.oldPinLabel(languageCode),
                  labelStyle: const TextStyle(color: Colors.grey),
                ),
              ),
                const SizedBox(height: 20),
              ],

              // Champ nouveau PIN
              TextField(
                controller: _pinController,
                obscureText: true,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(4),
                ],
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  letterSpacing: 8,
                ),
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  hintText: '••••',
                  hintStyle: TextStyle(
                    color: Colors.grey[600],
                    letterSpacing: 8,
                  ),
                  filled: true,
                  fillColor: Colors.grey[900],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 20),
                  labelText: widget.isChange
                      ? PinCodeLocalization.newPinLabel(languageCode)
                      : null,
                  labelStyle: const TextStyle(color: Colors.grey),
                ),
              ),

              const SizedBox(height: 20),

              // Champ confirmation
              TextField(
                controller: _confirmPinController,
                obscureText: true,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(4),
                ],
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  letterSpacing: 8,
                ),
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  hintText: '••••',
                  hintStyle: TextStyle(
                    color: Colors.grey[600],
                    letterSpacing: 8,
                  ),
                  filled: true,
                  fillColor: Colors.grey[900],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 20),
                  labelText: PinCodeLocalization.confirmLabel(languageCode),
                  labelStyle: const TextStyle(color: Colors.grey),
                ),
              ),

              if (_errorMessage.isNotEmpty) ...[
                const SizedBox(height: 20),
                Text(
                  _errorMessage,
                  style: const TextStyle(color: Colors.red, fontSize: 14),
                  textAlign: TextAlign.center,
                ),
              ],

              const SizedBox(height: 40),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _handleSubmit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    PinCodeLocalization.submit(languageCode),
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getTitle(String languageCode) {
    if (widget.isChange) {
      return PinCodeLocalization.changeTitle(languageCode);
    }
    if (widget.isSetup) {
      return PinCodeLocalization.createTitle(languageCode);
    }
    return PinCodeLocalization.enterTitle(languageCode);
  }

  void _handleSubmit() async {
    final languageCode = HiveService.settings.get(
      'language',
      defaultValue: 'en',
    );

    setState(() {
      _errorMessage = '';
    });

    if (_pinController.text.length != 4) {
      setState(() {
      _errorMessage = PinCodeLocalization.pinLengthError(languageCode);
      });
      return;
    }

    if (_confirmPinController.text.length != 4) {
      setState(() {
        _errorMessage = PinCodeLocalization.confirmPinError(languageCode);
      });
      return;
    }

    if (_pinController.text != _confirmPinController.text) {
      setState(() {
        _errorMessage = PinCodeLocalization.pinMismatchError(languageCode);
      });
      return;
    }

    // Mode changement : vérifier l'ancien PIN
    if (widget.isChange) {
      if (_oldPinController.text.length != 4) {
        setState(() {
          _errorMessage = PinCodeLocalization.enterOldPinError(languageCode);
        });
        return;
      }

      final savedPin = await _secureStorage.read(key: 'pin_code');
      if (_oldPinController.text != savedPin) {
        setState(() {
          _errorMessage = PinCodeLocalization.oldPinIncorrect(languageCode);
          _oldPinController.clear();
        });
        return;
      }
    }

    // Sauvegarder le nouveau PIN
    await _secureStorage.write(key: 'pin_code', value: _pinController.text);

    if (mounted) {
      if (widget.isSetup && !widget.isChange) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => widget.child),
        );
      } else {
        Navigator.of(context).pop();
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            widget.isSetup && !widget.isChange
                ? PinCodeLocalization.pinSetSuccess(languageCode)
                : PinCodeLocalization.pinChangedSuccess(languageCode),
          ),
        ),
      );
    }
  }
}
