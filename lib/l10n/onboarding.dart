class OnboardingLocalization {
  // ────────────── TITRE ──────────────
  static String welcome(String languageCode) {
    switch (languageCode) {
      case 'fr':
        return 'Bienvenue dans Thought';
      case 'fi':
        return 'Tervetuloa Thoughtiin';
      case 'sv':
        return 'Välkommen till Thought';
      default:
        return 'Welcome to Thought';
    }
  }

  // ────────────── INSTRUCTIONS ──────────────
  static String defaultPinSetup(String languageCode) {
    switch (languageCode) {
      case 'fr':
        return 'Créez un code PIN pour protéger vos pensées';
      case 'fi':
        return 'Luo PIN-koodi ajatustesi suojaamiseksi';
      case 'sv':
        return 'Skapa en PIN-kod för att skydda dina tankar';
      default:
        return 'Create a PIN to protect your thoughts';
    }
  }

  static String swipeRightToSave(String languageCode) {
    switch (languageCode) {
      case 'fr':
        return 'Glisse vers la droite pour sauvegarder ta pensée';
      case 'fi':
        return 'Pyyhkäise oikealle tallentaaksesi ajatuksesi';
      case 'sv':
        return 'Svep åt höger för att spara din tanke';
      default:
        return 'Swipe right to save your thought';
    }
  }

  static String swipeUpForList(String languageCode) {
    switch (languageCode) {
      case 'fr':
        return 'Glisse vers le haut pour ouvrir la liste de tes pensées';
      case 'fi':
        return 'Pyyhkäise ylös avataksesi ajatuslistasi';
      case 'sv':
        return 'Svep uppåt för att öppna din tankelista';
      default:
        return 'Swipe up to open your thoughts list';
    }
  }

  static String clickToPreview(String languageCode) {
    switch (languageCode) {
      case 'fr':
        return 'Clique sur une pensée pour la voir en entier';
      case 'fi':
        return 'Napauta ajatusta nähdäksesi sen kokonaan';
      case 'sv':
        return 'Tryck på en tanke för att se den helt';
      default:
        return 'Tap on a thought to preview it';
    }
  }

  static String swipeLeftToDelete(String languageCode) {
    switch (languageCode) {
      case 'fr':
        return 'Glisse vers la gauche pour supprimer une pensée';
      case 'fi':
        return 'Pyyhkäise vasemmalle poistaaksesi ajatuksen';
      case 'sv':
        return 'Svep åt vänster för att ta bort en tanke';
      default:
        return 'Swipe left to delete a thought';
    }
  }

  static String closeBottomSheet(String languageCode) {
    switch (languageCode) {
      case 'fr':
        return 'Glisse vers le bas pour fermer la liste';
      case 'fi':
        return 'Pyyhkäise alas sulkeaksesi listan';
      case 'sv':
        return 'Svep nedåt för att stänga listan';
      default:
        return 'Swipe down to close the list';
    }
  }

  // ────────────── BOUTON ──────────────
  static String getStarted(String languageCode) {
    switch (languageCode) {
      case 'fr':
        return 'Commencer';
      case 'fi':
        return 'Aloita';
      case 'sv':
        return 'Kom igång';
      default:
        return 'Get Started';
    }
  }
}
