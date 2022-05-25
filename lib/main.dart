import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:localdb/Database/dbHelper.dart';
import 'package:localdb/model/Employee.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SQL Database',
      theme: ThemeData(primarySwatch: Colors.brown),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => new MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  Employee employee = Employee("", "", "", "");

  late String firstName;
  late String lastName;
  late String mobileNo;
  late String emailId;

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Employee Form'),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.view_list))],
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              TextFormField(
                keyboardType: TextInputType.text,
                decoration: InputDecoration(labelText: 'FirstName'),
                validator: (val) => val?.length == 0 ? "Enter FirstName" : null,
                onSaved: (val) => firstName = val!,
              ),
              TextFormField(
                keyboardType: TextInputType.text,
                decoration: InputDecoration(labelText: 'LastName'),
                validator: (val) => val?.length == 0 ? "Enter LastName" : null,
                onSaved: (val) => lastName = val!,
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'MobileNo'),
                validator: (val) => val?.length == 0 ? "Enter MobileNo" : null,
                onSaved: (val) => mobileNo = val!,
              ),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(labelText: 'EmailId'),
                validator: (val) =>
                    val?.length == 0 ? "Enter EmailAddress" : null,
                onSaved: (val) => emailId = val!,
              ),
              Container(
                child: ElevatedButton(
                  onPressed: submit,
                  child: Text("Save Employee"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void submit() {
    if (formKey.currentState!.validate()) {
      formKey.currentState?.save();
    } else {
      return null;
    }

    var employee = Employee(firstName, lastName, mobileNo, emailId);

    var dbHelper = DBHelper();

    dbHelper.saveEmployee(employee);
    showSnackBar("Data Saved Successfully");
  }

  void showSnackBar(String text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
  }
}
