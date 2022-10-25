import 'package:mysql1/mysql1.dart';

class MySql {
  static String host = '192.168.8.153',
      user = 'root',
      password = 'abergymmobile_kp',
      db = 'AberGymDb';
  static int port = 3306;

  MySql();

  Future<MySqlConnection> getConnection() async {
    var settings = ConnectionSettings(
        host: host, password: password, user: user, db: db, port: port);
    return await MySqlConnection.connect(settings);
  }
}
