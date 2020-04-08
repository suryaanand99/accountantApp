class User {
  final String accessToken;
  final int statusCode;

  User({this.accessToken, this.statusCode});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      accessToken: json['accessToken'],
      statusCode: json['statusCode'],
    );
  }
}

class Resp {
  final Account account;
  final statusCode;
  final String accessToken;

  Resp({this.account, this.statusCode, this.accessToken});

  factory Resp.fromJson(Map<String, dynamic> json, int status, String token) {
    return Resp(
        account: Account.fromJson(json['account']),
        statusCode: status,
        accessToken: token);
  }
}

class Account {
  final List<DayObjPro> dailySummary;
  final List<MonthlyObjPro> monthlySummary;
  final List<YearlyObjPro> yearlySummary;

  Account({this.dailySummary, this.monthlySummary, this.yearlySummary});

  factory Account.fromJson(Map<String, dynamic> json) {
    return Account(
      dailySummary: parseDailySummary(json),
      monthlySummary: parseMonthlySummary(json),
      yearlySummary: parseYearlySummary(json),
    );
  }

  static List<DayObjPro> parseDailySummary(summary) {
    var list = summary['dailySummary'] as List;
    List<DayObjPro> summaryList =
        list.map((data) => DayObjPro.fromJson(data)).toList();
    return summaryList;
  }

  static List<MonthlyObjPro> parseMonthlySummary(summary) {
    var list = summary['monthlySummary'] as List;
    List<MonthlyObjPro> summaryList =
        list.map((data) => MonthlyObjPro.fromJson(data)).toList();
    return summaryList;
  }

  static List<YearlyObjPro> parseYearlySummary(summary) {
    var list = summary['yearlySummary'] as List;
    List<YearlyObjPro> summaryList =
        list.map((data) => YearlyObjPro.fromJson(data)).toList();
    return summaryList;
  }
}

//this for daily summary
class DayObjPro {
  final int profit;
  final int income;
  final int expenditure;
  final String dailyCreatedAt;

  DayObjPro({this.profit, this.income, this.expenditure, this.dailyCreatedAt});

  factory DayObjPro.fromJson(Map<String, dynamic> json) {
    return DayObjPro(
      profit: json['profit'],
      income: json['income'],
      expenditure: json['expenditure'],
      dailyCreatedAt: json['dailyCreatedAt'],
    );
  }
}

//this for monthly summary
class MonthlyObjPro {
  final int profit;
  final int income;
  final int expenditure;
  final String monthlyCreatedAt;

  MonthlyObjPro(
      {this.profit, this.income, this.expenditure, this.monthlyCreatedAt});

  factory MonthlyObjPro.fromJson(Map<String, dynamic> json) {
    return MonthlyObjPro(
      profit: json['profit'],
      income: json['income'],
      expenditure: json['expenditure'],
      monthlyCreatedAt: json['monthlyCreatedAt'],
    );
  }
}

//this is for yealy summary
class YearlyObjPro {
  final int profit;
  final int income;
  final int expenditure;
  final int year;

  YearlyObjPro({this.profit, this.income, this.expenditure, this.year});

  factory YearlyObjPro.fromJson(Map<String, dynamic> json) {
    return YearlyObjPro(
      profit: json['profit'],
      income: json['income'],
      expenditure: json['expenditure'],
      year: json['year'],
    );
  }
}
