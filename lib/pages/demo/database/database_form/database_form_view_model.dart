import 'package:flutter/material.dart';

import 'package:flutter_demo/database/database.dart';

import 'database_form_model.dart';

class DatabaseFormViewModel extends ChangeNotifier {
  bool _mounted = true;

  final DatabaseFormModel model = DatabaseFormModel();
  final TextEditingController textFieldController = TextEditingController();
  final TextEditingController doubleFieldController = TextEditingController();

  Future<void> init(BuildContext context, int? demoId) async {
    if (demoId != null) {
      model.id = demoId;
      final database = DemoDatabase();
      final demo = await database.demoDao.getDemoById(demoId);
      if (!_mounted) return;
      if (demo != null) {
        model.textField = demo.demoTextField;
        model.doubleField = '${demo.demoDoubleField}';
        textFieldController.text = demo.demoTextField;
        doubleFieldController.text = '${demo.demoDoubleField}';
      }
    }
    notifyListeners();
  }

  void cleanup() {
    _mounted = false;
    textFieldController.dispose();
    doubleFieldController.dispose();
  }

  Future<bool> save(BuildContext context) async {
    if (model.isSaving) return false;
    model.isSaving = true;
    notifyListeners();

    final text = textFieldController.text.trim();
    final doubleStr = doubleFieldController.text.trim();

    if (text.isEmpty) {
      model.isSaving = false;
      notifyListeners();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('请输入文本内容')),
      );
      return false;
    }

    double? doubleValue;
    if (doubleStr.isNotEmpty) {
      doubleValue = double.tryParse(doubleStr);
      if (doubleValue == null) {
        model.isSaving = false;
        notifyListeners();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('请输入有效的数字')),
        );
        return false;
      }
    }

    final database = DemoDatabase();

    if (model.id != null) {
      await database.demoDao.updateDemo(
        model.id!,
        demoTextField: text,
        demoDoubleField: doubleValue,
      );
    } else {
      await database.demoDao.insertDemo(
        demoTextField: text,
        demoDoubleField: doubleValue ?? 0.0,
      );
    }

    model.isSaving = false;
    notifyListeners();
    Navigator.pop(context);
    return true;
  }

  Future<void> delete(BuildContext context) async {
    if (model.id != null) {
      final database = DemoDatabase();
      await database.demoDao.deleteDemo(model.id!);
    }
  }
} 
