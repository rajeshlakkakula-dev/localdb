import 'package:localdb/model/Employee.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static late Database database;

  Future<Database> get db async {


    database = await initDb();

    return database;
  }

  initDb() async {
    String path = join(await getDatabasesPath(), 'test.db');

   final theDb = openDatabase(path, onCreate: (db, version) {
      return db.execute(
          'CREATE TABLE Employee(id INTEGER PRIMARY KEY,firstName TEXT, lastName TEXT, mobileNo INTEGER, emailId TEXT)');
    }, version: 1);

    return theDb;
  }

  void saveEmployee(Employee employee) async {
    var dbClient = await db;

    await dbClient.transaction(((txn) async {
      return await txn.rawInsert(
          'INSERT INTO Employee(firstName,lastName,mobileNo,emailId) VALUES(' +
              '\'' +
              employee.firstName +
              '\'' +
              ',' +
              '\'' +
              employee.lastName +
              '\'' +
              ',' +
              '\'' +
              employee.mobileNo +
              '\'' +
              ',' +
              '\'' +
              employee.emailId +
              '\'' +
              ')');
    }));

    print("save Tables");
  }

  Future<List<Employee>> getEmployees() async {
    var dbClient = await db;

    List<Map> list = await dbClient.rawQuery('SELECT * FROM Employee');

    List<Employee> employees = [];

    for (int i = 0; i < employees.length; i++) {
      employees.add(Employee(list[i]["firstName"], list[i]["lastName"],
          list[i]["mobileNo"], list[i]["emailId"]));
    }

    print(employees.length);
    return employees;
  }
}
