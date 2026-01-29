class SettingsLocalization {
  static String settingsPageTitle(String lang) {
    switch (lang) {
      case 'fr':
        return 'Paramètres';
      case 'fi':
        return 'Asetukset';
      case 'sv':
        return 'Inställningar';
      default:
        return 'Settings';
    }
  }
}

class DisplayOnboardingLocalization {
  static String displayOnboarding(String lang) {
    switch (lang) {
      case 'fr':
        return "Afficher l'introduction";
      case 'fi':
        return 'Näytä esittely';
      case 'sv':
        return 'Visa introduktion';
      default:
        return 'Show onboarding';
    }
  }
}

class FeedbackLocalization {
  static String feedback(String lang) {
    switch (lang) {
      case 'fr':
        return 'Envoyer des commentaires';
      case 'fi':
        return 'Lähetä palautetta';
      case 'sv':
        return 'Skicka feedback';
      default:
        return 'Send feedback';
    }
  }
}

class ManagePinLocalization {
  static String cancel(String lang) {
    switch (lang) {
      case 'fr':
        return 'Annuler';
      case 'fi':
        return 'Peruuta';
      case 'sv':
        return 'Avbryt';
      default:
        return 'Cancel';
    }
  }

  static String managePin(String lang) {
    switch (lang) {
      case 'fr':
        return 'Gérer le code PIN';
      case 'fi':
        return 'Hallitse PIN-koodia';
      case 'sv':
        return 'Hantera PIN-kod';
      default:
        return 'Manage PIN';
    }
  }

  static String changePin(String lang) {
    switch (lang) {
      case 'fr':
        return 'Changer le PIN';
      case 'fi':
        return 'Vaihda PIN-koodi';
      case 'sv':
        return 'Byt PIN-kod';
      default:
        return 'Change PIN';
    }
  }

  static String previousPin(String lang) {
    switch (lang) {
      case 'fr':
        return 'Code PIN actuel';
      case 'fi':
        return 'Nykyinen PIN-koodi';
      case 'sv':
        return 'Nuvarande PIN-kod';
      default:
        return 'Current PIN';
    }
  }

  static String newPin(String lang) {
    switch (lang) {
      case 'fr':
        return 'Nouveau code PIN';
      case 'fi':
        return 'Uusi PIN-koodi';
      case 'sv':
        return 'Ny PIN-kod';
      default:
        return 'New PIN';
    }
  }

  static String resetConfirmTitle(String lang) {
    switch (lang) {
      case 'fr':
        return 'Confirmer la réinitialisation du PIN';
      case 'fi':
        return 'Vahvista PIN-koodin nollaus';
      case 'sv':
        return 'Bekräfta PIN-återställning';
      default:
        return 'Confirm PIN reset';
    }
  }

  static String resetConfirmMessage(String lang) {
    switch (lang) {
      case 'fr':
        return 'Attention : réinitialiser le PIN supprimera toutes tes pensées. Cette action est irréversible. Es-tu sûr de vouloir continuer ?';
      case 'fi':
        return 'Varoitus: PIN-koodin nollaaminen poistaa kaikki ajatuksesi. Tätä toimintoa ei voi peruuttaa. Haluatko varmasti jatkaa?';
      case 'sv':
        return 'Varning: Återställning av PIN-koden tar bort alla dina tankar. Denna åtgärd kan inte ångras. Är du säker på att du vill fortsätta?';
      default:
        return 'Warning: resetting the PIN will delete all your thoughts. This action is irreversible. Are you sure you want to continue?';
    }
  }

  static String resetConfirm(String lang) {
    switch (lang) {
      case 'fr':
        return 'Réinitialiser';
      case 'fi':
        return 'Nollaa';
      case 'sv':
        return 'Återställ';
      default:
        return 'Reset';
    }
  }

  static String resetPin(String lang) {
    switch (lang) {
      case 'fr':
        return 'Réinitialiser le code PIN';
      case 'fi':
        return 'Nollaa PIN-koodi';
      case 'sv':
        return 'Återställ PIN-kod';
      default:
        return 'Reset PIN';
    }
  }

  static String resetSuccessMessage(String lang) {
    switch (lang) {
      case 'fr':
        return 'Code PIN et pensées réinitialisés avec succès';
      case 'fi':
        return 'PIN-koodi ja ajatukset nollattu onnistuneesti';
      case 'sv':
        return 'PIN-kod och tankar återställda framgångsrikt';
      default:
        return 'PIN and thoughts reset successfully';
    }
  }

  static String samePinMessage(String lang) {
    switch (lang) {
      case 'fr':
        return 'Le nouveau code PIN doit être différent de l\'ancien';
      case 'fi':
        return 'Uuden PIN-koodin on oltava erilainen kuin vanhan';
      case 'sv':
        return 'Den nya PIN-koden måste vara annorlunda än den gamla';
      default:
        return 'The new PIN must be different from the old one';
    }
  }

  static String savePin(String lang) {
    switch (lang) {
      case 'fr':
        return 'Enregistrer';
      case 'fi':
        return 'Tallenna';
      case 'sv':
        return 'Spara';
      default:
        return 'Save';
    }
  }

  static String shortPinMessage(String lang) {
    switch (lang) {
      case 'fr':
        return 'Le code PIN doit comporter au moins 4 chiffres';
      case 'fi':
        return 'PIN-koodin on oltava vähintään 4 numeroa';
      case 'sv':
        return 'PIN-koden måste vara minst 4 siffror';
      default:
        return 'PIN must be at least 4 digits long';
    }
  }

  static String successMessage(String lang) {
    switch (lang) {
      case 'fr':
        return 'PIN mis à jour avec succès';
      case 'fi':
        return 'PIN-koodi päivitetty onnistuneesti';
      case 'sv':
        return 'PIN-kod uppdaterad framgångsrikt';
      default:
        return 'PIN updated successfully';
    }
  }

  static String failureMessage(String lang) {
    switch (lang) {
      case 'fr':
        return 'Code PIN actuel incorrect';
      case 'fi':
        return 'Nykyinen PIN-koodi on virheellinen';
      case 'sv':
        return 'Nuvarande PIN-kod är felaktig';
      default:
        return 'Current PIN is incorrect';
    }
  }
}

class SetLanguageLocalization {
  static String setLanguage(String lang) {
    switch (lang) {
      case 'fr':
        return 'Changer la langue';
      case 'fi':
        return 'Vaihda kieli';
      case 'sv':
        return 'Byt språk';
      default:
        return 'Change language';
    }
  }

  static String chooseLanguage(String lang) {
    switch (lang) {
      case 'fr':
        return 'Choisir une langue';
      case 'fi':
        return 'Valitse kieli';
      case 'sv':
        return 'Välj språk';
      default:
        return 'Choose language';
    }
  }

  static String languageChanged(String lang) {
    switch (lang) {
      case 'fr':
        return 'Langue changée en Français';
      case 'fi':
        return 'Kieli vaihdettu suomeksi';
      case 'sv':
        return 'Språket ändrat till Svenska';
      default:
        return 'Language changed to English';
    }
  }
}

class ResetThoughtsLocalization {
  static String resetThoughts(String lang) {
    switch (lang) {
      case 'fr':
        return 'Réinitialiser toutes les pensées';
      case 'fi':
        return 'Nollaa kaikki ajatukset';
      case 'sv':
        return 'Återställ alla tankar';
      default:
        return 'Reset all thoughts';
    }
  }

  static String resetThoughtsConfirmationTitle(String lang) {
    switch (lang) {
      case 'fr':
        return 'Confirmer la réinitialisation';
      case 'fi':
        return 'Vahvista nollaus';
      case 'sv':
        return 'Bekräfta återställning';
      default:
        return 'Confirm reset';
    }
  }

  static String resetThoughtsConfirmationMessage(String lang) {
    switch (lang) {
      case 'fr':
        return 'Es-tu sûr de vouloir supprimer toutes tes pensées ? Cette action est irréversible.';
      case 'fi':
        return 'Haluatko varmasti poistaa kaikki ajatuksesi? Tätä toimintoa ei voi peruuttaa.';
      case 'sv':
        return 'Är du säker på att du vill ta bort alla dina tankar? Denna åtgärd kan inte ångras.';
      default:
        return 'Are you sure you want to delete all your thoughts? This action is irreversible.';
    }
  }

  static String resetThoughtsButton(String lang) {
    switch (lang) {
      case 'fr':
        return 'Réinitialiser';
      case 'fi':
        return 'Nollaa';
      case 'sv':
        return 'Återställ';
      default:
        return 'Reset';
    }
  }

  static String cancel(String lang) {
    switch (lang) {
      case 'fr':
        return 'Annuler';
      case 'fi':
        return 'Peruuta';
      case 'sv':
        return 'Avbryt';
      default:
        return 'Cancel';
    }
  }

  static String successMessage(String lang) {
    switch (lang) {
      case 'fr':
        return 'Toutes les pensées ont été supprimées avec succès';
      case 'fi':
        return 'Kaikki ajatukset on poistettu onnistuneesti';
      case 'sv':
        return 'Alla tankar har tagits bort framgångsrikt';
      default:
        return 'All thoughts have been successfully deleted';
    }
  }
}
