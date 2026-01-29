class ThoughtLocalization {
  static String detailsTitle(String lang) {
    switch (lang) {
      case 'fr':
        return 'Détails de la pensée';
      case 'fi':
        return 'Ajatuksen tiedot';
      case 'sv':
        return 'Tankedetaljer';
      default:
        return 'Thought details';
    }
  }

  static String emptyWarning(String lang) {
    switch (lang) {
      case 'fr':
        return 'La pensée ne peut pas être vide';
      case 'fi':
        return 'Ajatus ei voi olla tyhjä';
      case 'sv':
        return 'Tanken kan inte vara tom';
      default:
        return 'Thought cannot be empty';
    }
  }

  static String saved(String lang) {
    switch (lang) {
      case 'fr':
        return 'Pensée enregistrée';
      case 'fi':
        return 'Ajatus tallennettu';
      case 'sv':
        return 'Tanke sparad';
      default:
        return 'Thought saved';
    }
  }

  static String deleteTitle(String lang) {
    switch (lang) {
      case 'fr':
        return 'Supprimer cette pensée ?';
      case 'fi':
        return 'Poista tämä ajatus?';
      case 'sv':
        return 'Ta bort denna tanke?';
      default:
        return 'Delete this thought?';
    }
  }

  static String deleteMessage(String lang) {
    switch (lang) {
      case 'fr':
        return 'Cette action est irréversible.';
      case 'fi':
        return 'Tätä toimintoa ei voi peruuttaa.';
      case 'sv':
        return 'Denna åtgärd kan inte ångras.';
      default:
        return 'This action cannot be undone.';
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

  static String delete(String lang) {
    switch (lang) {
      case 'fr':
        return 'Supprimer';
      case 'fi':
        return 'Poista';
      case 'sv':
        return 'Ta bort';
      default:
        return 'Delete';
    }
  }
}
