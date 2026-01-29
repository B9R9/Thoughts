class PinCodeLocalization {
  static String oldPinLabel(String lang) {
    switch (lang) {
      case 'fr':
        return 'Ancien PIN';
      case 'fi':
        return 'Vanha PIN-koodi';
      case 'sv':
        return 'Gammal PIN-kod';
      default:
        return 'Old PIN';
    }
  }

  static String newPinLabel(String lang) {
    switch (lang) {
      case 'fr':
        return 'Nouveau PIN';
      case 'fi':
        return 'Uusi PIN-koodi';
      case 'sv':
        return 'Ny PIN-kod';
      default:
        return 'New PIN';
    }
  }

  static String confirmLabel(String lang) {
    switch (lang) {
      case 'fr':
        return 'Confirmation';
      case 'fi':
        return 'Vahvistus';
      case 'sv':
        return 'Bekräfta';
      default:
        return 'Confirm';
    }
  }

  static String submit(String lang) {
    switch (lang) {
      case 'fr':
        return 'Valider';
      case 'fi':
        return 'Vahvista';
      case 'sv':
        return 'Bekräfta';
      default:
        return 'Submit';
    }
  }

  static String changeTitle(String lang) {
    switch (lang) {
      case 'fr':
        return 'Changer le code PIN';
      case 'fi':
        return 'Vaihda PIN-koodi';
      case 'sv':
        return 'Byt PIN-kod';
      default:
        return 'Change PIN code';
    }
  }

  static String createTitle(String lang) {
    switch (lang) {
      case 'fr':
        return 'Créez votre code PIN';
      case 'fi':
        return 'Luo PIN-koodi';
      case 'sv':
        return 'Skapa PIN-kod';
      default:
        return 'Create your PIN code';
    }
  }

  static String enterTitle(String lang) {
    switch (lang) {
      case 'fr':
        return 'Entrez votre code PIN';
      case 'fi':
        return 'Syötä PIN-koodisi';
      case 'sv':
        return 'Ange din PIN-kod';
      default:
        return 'Enter your PIN code';
    }
  }

  static String pinLengthError(String lang) {
    switch (lang) {
      case 'fr':
        return 'Le code PIN doit contenir 4 chiffres';
      case 'fi':
        return 'PIN-koodin tulee olla 4 numeroa';
      case 'sv':
        return 'PIN-koden måste vara 4 siffror';
      default:
        return 'PIN code must be 4 digits';
    }
  }

  static String confirmPinError(String lang) {
    switch (lang) {
      case 'fr':
        return 'Veuillez confirmer le code PIN';
      case 'fi':
        return 'Vahvista PIN-koodi';
      case 'sv':
        return 'Bekräfta PIN-koden';
      default:
        return 'Please confirm the PIN code';
    }
  }

  static String pinMismatchError(String lang) {
    switch (lang) {
      case 'fr':
        return 'Les codes PIN ne correspondent pas';
      case 'fi':
        return 'PIN-koodit eivät vastaa';
      case 'sv':
        return 'PIN-koderna matchar inte';
      default:
        return 'PIN codes do not match';
    }
  }

  static String enterOldPinError(String lang) {
    switch (lang) {
      case 'fr':
        return 'Veuillez entrer l\'ancien PIN';
      case 'fi':
        return 'Syötä vanha PIN-koodi';
      case 'sv':
        return 'Ange gammal PIN-kod';
      default:
        return 'Please enter old PIN';
    }
  }

  static String oldPinIncorrect(String lang) {
    switch (lang) {
      case 'fr':
        return 'Ancien code PIN incorrect';
      case 'fi':
        return 'Vanha PIN-koodi on virheellinen';
      case 'sv':
        return 'Gammal PIN-kod är felaktig';
      default:
        return 'Incorrect old PIN code';
    }
  }

  static String pinSetSuccess(String lang) {
    switch (lang) {
      case 'fr':
        return 'Code PIN créé avec succès';
      case 'fi':
        return 'PIN-koodi asetettu onnistuneesti';
      case 'sv':
        return 'PIN-kod satt framgångsrikt';
      default:
        return 'PIN code set successfully';
    }
  }

  static String pinChangedSuccess(String lang) {
    switch (lang) {
      case 'fr':
        return 'Code PIN modifié avec succès';
      case 'fi':
        return 'PIN-koodi muutettu onnistuneesti';
      case 'sv':
        return 'PIN-kod ändrad framgångsrikt';
      default:
        return 'PIN code changed successfully';
    }
  }
}
