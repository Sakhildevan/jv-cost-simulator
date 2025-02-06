class TBWidth {
  //*----(ID width)
  double idWidth(double size) {
    if (size > 1000 && size <= 1200) {
      return .075;
    }
    if (size > 1400 && size <= 1800) {
      return .055;
    }
    if (size > 1800 && size <= 3000) {
      return .045;
    }
    if (size > 3000 && size <= 4000) {
      return .035;
    }
    if (size > 4000) {
      return .025;
    } else {
      return .07;
    }
  }

//*---(Business Unit Width)
  double busUnitWidth(double size) {
    if (size > 1000 && size <= 1200) {
      return .15;
    }
    if (size > 1200 && size <= 1300) {
      return .12;
    }
    if (size > 1300 && size <= 1600) {
      return .1;
    }
    if (size > 1600 && size <= 2000) {
      return .085;
    }
    if (size > 2000 && size <= 3000) {
      return .075;
    }
    if (size > 3000 && size <= 4000) {
      return .055;
    }
    if (size > 4000) {
      return .05;
    } else {
      return .1;
    }
  }

  //*----(Currency width)
  double currWidth(double size) {
    if (size > 1000 && size <= 1200) {
      return .1;
    }
    if (size > 1200 && size <= 1400) {
      return .095;
    }
    if (size > 1400 && size <= 1800) {
      return .07;
    }
    if (size > 1800 && size <= 2000) {
      return .06;
    }
    if (size > 2000 && size <= 3000) {
      return .05;
    }
    if (size > 3000 && size <= 4000) {
      return .04;
    }
    if (size > 4000) {
      return .025;
    } else {
      return .095;
    }
  }

  //*----(status width)
  double statusWidth(double size) {
    if (size > 1000 && size <= 1200) {
      return .12;
    }
    if (size > 1200 && size <= 1400) {
      return .095;
    }
    if (size > 1400 && size <= 1700) {
      return .08;
    }
    if (size > 1700 && size <= 1800) {
      return .07;
    }
    if (size > 1800 && size <= 2000) {
      return .06;
    }
    if (size > 2000 && size <= 3000) {
      return .06;
    }
    if (size > 3000 && size <= 4000) {
      return .04;
    }
    if (size > 4000) {
      return .025;
    } else {
      return .095;
    }
  }

  //*----(created on width)
  double createdOnWidth(double size) {
    if (size > 1000 && size <= 1200) {
      return .15;
    }
    if (size > 1200 && size <= 1400) {
      return .1;
    }
    if (size > 1400 && size <= 1700) {
      return .085;
    }
    if (size > 1700 && size <= 1800) {
      return .075;
    }
    if (size > 1800 && size <= 2000) {
      return .065;
    }
    if (size > 2000 && size <= 3000) {
      return .065;
    }
    if (size > 3000 && size <= 4000) {
      return .045;
    }
    if (size > 4000) {
      return .03;
    } else {
      return .095;
    }
  }
}
