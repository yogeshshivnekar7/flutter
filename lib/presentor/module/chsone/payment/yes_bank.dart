class Yesbank {
  static getMode(String a, var yesBankMod, String vpa) {
    switch (a) {
      case "CC":
        return {
          "img": "images/credit-card.png",
          "name": "Credit Card",
          "selected": false,
          "chsone_key": "CC",
          "key": "cc",
          // "rate": yesBankMod["rate"],
          "vpa": vpa
        };
        break;
      case "DB":
        return {
          "img": "images/debit-card.png",
          "name": "Debit Card",
          "selected": false,
          "chsone_key": "DB",
          "key": "db",
          // "rate": yesBankMod["rate"],
          "vpa": vpa
        };
        break;
      case "NB":
        return {
          "img": "images/netbanking.png",
          "name": "NetBanking",
          "selected": false,
          "chsone_key": "NB",
          "key": "nb",
          // "rate": yesBankMod["rate"],
          "vpa": vpa
        };
        break;
    }
  }
}
