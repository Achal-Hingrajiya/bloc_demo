import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'employee_cls.dart';

part 'employee_event.dart';

part 'employee_state.dart';

// Imports
// List of employees
// Stream controllers
// Stream, Sink getter
// Constructor add data, listen changes
// core functions
// dispose

class EmployeeBloc extends Bloc<EmployeeEvent, EmployeeState> {
  final List<Employee> _employeeList = [
    Employee(1, "Employee1", 100000.0),
    Employee(2, "Employee2", 200000.0),
    Employee(3, "Employee3", 300000.0),
    Employee(4, "Employee4", 400000.0),
    Employee(5, "Employee5", 500000.0),
    Employee(6, "Employee6", 600000.0),
    Employee(7, "Employee7", 700000.0),
    Employee(7, "Employee8", 700000.0),
    Employee(7, "Employee9", 700000.0),
    Employee(7, "Employee10", 700000.0),
    Employee(7, "Employee11", 700000.0),
    Employee(7, "Employee12", 700000.0),
  ];

  //sink => put data in stream
  //stream => get data from stream

  // Stream Controllers
  final _employeeListStreamController = StreamController<List<Employee>>();
  final _employeeSalaryIncreamentStreamController =
      StreamController<Employee>();
  final _employeeSalaryDecrementStreamController = StreamController<Employee>();

  // Getters
  Stream<List<Employee>> get employeeListStream =>
      _employeeListStreamController.stream;

  StreamSink<List<Employee>> get employeeListSink =>
      _employeeListStreamController.sink;

  StreamSink<Employee> get employeeSalaryIncreament =>
      _employeeSalaryIncreamentStreamController.sink;

  StreamSink<Employee> get employeeSalaryDecreament =>
      _employeeSalaryDecrementStreamController.sink;

  EmployeeBloc() : super(EmployeeInitial()) {
    _employeeListStreamController.add(_employeeList);

    _employeeSalaryIncreamentStreamController.stream.listen(_increamentSalary);
    _employeeSalaryDecrementStreamController.stream.listen(_decrementSalary);
  }

  void _increamentSalary(Employee employee) {
    double salary = employee.salary;
    double newSalary = salary + (salary * 0.20);

    _employeeList[employee.id - 1].salary = newSalary;

    employeeListSink.add(_employeeList);
  }

  void _decrementSalary(Employee employee) {
    double salary = employee.salary;
    double newSalary = salary - (salary * 0.20);

    _employeeList[employee.id - 1].salary = newSalary;

    employeeListSink.add(_employeeList);
  }

  void dispose() {
    _employeeSalaryIncreamentStreamController.close();
    _employeeSalaryDecrementStreamController.close();
    _employeeListStreamController.close();
  }
}
