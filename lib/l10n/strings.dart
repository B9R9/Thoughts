class Strings {
  static String appTitle(String lang) {
    switch (lang) {
      case 'fr':
        return 'Pensées';
      case 'fi':
        return 'Ajatukset';
      case 'sv':
        return 'Tanke';
      default:
        return 'Thought';
    }
  }

  static String thoughts(String lang) {
    switch (lang) {
      case 'fr':
        return 'Mes pensées';
      case 'fi':
        return 'Ajatukseni';
      case 'sv':
        return 'Mina tankar';
      default:
        return 'My thoughts';
    }
  }

  static String hintInput(String lang) {
    switch (lang) {
      case 'fr':
        return 'Écrivez vos pensées ici...';
      case 'fi':
        return 'Kirjoita ajatuksesi tähän...';
      case 'sv':
        return 'Skriv dina tankar här...';
      default:
        return 'Write your thoughts here...';
    }
  }

  static String unlockYourThoughts(String lang) {
    switch (lang) {
      case 'fr':
        return 'Déverrouillez vos pensées';
      case 'fi':
        return 'Avaa ajatuksesi';
      case 'sv':
        return 'Lås upp dina tankar';
      default:
        return 'Unlock your thoughts';
    }
  }

  static String pinIncorrect(String lang) {
    switch (lang) {
      case 'fr':
        return 'PIN incorrect';
      case 'fi':
        return 'Virheellinen PIN-koodi';
      case 'sv':
        return 'Felaktig PIN-kod';
      default:
        return 'Incorrect PIN';
    }
  }

  static String unlockWithPin(String lang) {
    switch (lang) {
      case 'fr':
        return 'Déverrouiller';
      case 'fi':
        return 'Avaa';
      case 'sv':
        return 'Lås upp';
      default:
        return 'Unlock';
    }
  }

  static String enterPin(String lang) {
    switch (lang) {
      case 'fr':
        return 'Entrez votre PIN';
      case 'fi':
        return 'Syötä PIN-koodisi';
      case 'sv':
        return 'Ange din PIN-kod';
      default:
        return 'Enter your PIN';
    }
  }

  static String pinHint(String lang) {
    switch (lang) {
      case 'fr':
        return 'PIN';
      case 'fi':
        return 'PIN';
      case 'sv':
        return 'PIN';
      default:
        return 'PIN';
    }
  }

  static Map<String, String> groupTitles(String lang) {
    switch (lang) {
      case 'fr':
        return {
          'today': "Aujourd'hui",
          'this_week': "Cette semaine",
          'last_week': "Semaine dernière",
          'this_month': "Ce mois-ci",
          'last_month': "Mois précédent",
          'two_months_ago': "Il y a 2 mois",
          'older': "Plus ancien",
        };
      case 'fi':
        return {
          'today': "Tänään",
          'this_week': "Tällä viikolla",
          'last_week': "Viime viikolla",
          'this_month': "Tässä kuussa",
          'last_month': "Viime kuussa",
          'two_months_ago': "2 kuukautta sitten",
          'older': "Vanhemmat",
        };
      case 'sv':
        return {
          'today': "Idag",
          'this_week': "Denna vecka",
          'last_week': "Förra veckan",
          'this_month': "Denna månad",
          'last_month': "Förra månaden",
          'two_months_ago': "2 månader sedan",
          'older': "Äldre",
        };
      default:
        return {
          'today': "Today",
          'this_week': "This week",
          'last_week': "Last week",
          'this_month': "This month",
          'last_month': "Last month",
          'two_months_ago': "2 months ago",
          'older': "Older",
        };
    }
  }
}
