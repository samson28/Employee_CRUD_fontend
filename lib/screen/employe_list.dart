import 'package:employee_crud_fontend/model/employee.dart';
import 'package:employee_crud_fontend/repository/employee_repository.dart';
import 'package:employee_crud_fontend/repository/user_repository.dart';
import 'package:employee_crud_fontend/screen/login.dart';
import 'package:employee_crud_fontend/widget/employe_item_widget.dart';
import 'package:flutter/material.dart';

class EmployeList extends StatefulWidget {
  const EmployeList({super.key});

  @override
  State<EmployeList> createState() => _EmployeListState();
}

class _EmployeListState extends State<EmployeList> {
  List<Employe> employes = [];

  @override
  void initState() {
    getEmp();
    super.initState();
  }

  getEmp() async {
    List<Employe> x = await EmployeRepo().getEmploye();
    setState(() {
      employes = x;
    });
  }

  delEmp(Employe employe) {
    EmployeRepo().deleteEmploye(employe);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Liste des Employées'),
        actions: [
          IconButton(
              onPressed: () async {
                await UserRepo().logout();
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute<void>(
                        builder: (BuildContext context) => const Login()),
                    (route) => false);
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      body: ListView.builder(
        itemCount: employes.length,
        itemBuilder: (context, index) {
          final employe = employes[index];
          return Dismissible(
              key: Key(employe.id.toString()),
              onDismissed: (direction) {
                setState(() {
                  delEmp(employe);
                  employes.remove(employe);
                });
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("${employe.nom} supprimé")));
              },
              background: Container(color: Colors.red),
              child: EmployeItemWidget(
                employe: employe,
              ));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, '/addEmp'),
        child: const Icon(Icons.add),
      ),
    );
  }
}
