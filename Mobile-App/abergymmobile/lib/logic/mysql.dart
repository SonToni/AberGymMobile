import 'package:mysql1/mysql1.dart';
import 'package:mysql_client/mysql_client.dart';

class MySql {
  final pool = MySQLConnectionPool(
    host: '192.168.8.153',
    port: 3306,
    userName: 'root',
    password: 'abergymmobile_kp',
    maxConnections: 10,
    databaseName: 'AberGymDb', // optional,
  );
}
