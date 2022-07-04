import 'package:bloc_demo/employee_bloc.dart';
import 'package:bloc_demo/employee_cls.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final EmployeeBloc _employeeBloc = EmployeeBloc();

  @override
  void dispose() {
    _employeeBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: StreamBuilder<List<Employee>>(
        stream: _employeeBloc.employeeListStream as Stream<List<Employee>>?,
        builder:
            (BuildContext context, AsyncSnapshot<List<Employee>> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data?.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  elevation: 5.0,
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(15),
                        child: Column(
                          children: [
                            Text("${snapshot.data![index].name} "),
                            const SizedBox(
                              height: 10,
                            ),
                            Text("Rs. ${snapshot.data![index].salary} "),
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          IconButton(
                            onPressed: () {
                              _employeeBloc.employeeSalaryIncreament
                                  .add(snapshot.data![index]);
                            },
                            icon: const Icon(
                              Icons.add_circle,
                              color: Colors.greenAccent,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          IconButton(
                            onPressed: () {
                              _employeeBloc.employeeSalaryDecreament
                                  .add(snapshot.data![index]);
                            },
                            icon: const Icon(
                              Icons.remove_circle,
                              color: Colors.redAccent,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                );
              },
            );
          } else {
            return const Center(
              child: SizedBox(
                height: 50,
                width: 50,
                child: const CircularProgressIndicator(),
              ),
            );
          }
        },
      ),
    );
  }
}
