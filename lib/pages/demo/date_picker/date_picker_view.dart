import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:board_datetime_picker/board_datetime_picker.dart';

import 'package:flutter_demo/layout/custom_app_bar.dart';
import 'package:flutter_demo/widget/datetime_picker/datetime_picker.dart';
import 'package:flutter_demo/utils/message.dart';

import 'date_picker_view_model.dart';

/* 
 * DatePicker页面
 */
class DatePickerView extends StatefulWidget {
  const DatePickerView({super.key});

  @override
  State<DatePickerView> createState() => _DatePickerViewState();
}

class _DatePickerViewState extends State<DatePickerView> {
  late final DatePickerViewModel viewModel;

  /* 
   * 初始化
   */
  @override
  void initState() {
    super.initState();
    viewModel = DatePickerViewModel();
  }

  /* 
   * 页面构建
   */
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: viewModel,
      child: Consumer<DatePickerViewModel>(
        builder: (context, viewModel, child) {
          /* 
           * 页面
           */
          return Scaffold(
            appBar: CustomAppBar(title: const Text('日期选择器')),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  /* 日期选择器 */
                  ElevatedButton(
                    onPressed: () async {
                      final result = await showBoardDateTimePicker(
                        context: context,
                        pickerType: DateTimePickerType.date,
                        initialDate: DateTime.now(),
                        minimumDate: DateTime(2015, 1, 1),
                        maximumDate: DateTime(2093, 1, 1),
                        options: getBoardDateTimeOptions(context),
                      );

                      if (result != null) {
                        final dateStr =
                            "${result.year}-${result.month}-${result.day}";
                        if (context.mounted) {
                          showTextSnackBar(context, msg: dateStr);
                        }
                      }
                    },
                    child: const Text('日期选择器'),
                  ),

                  /* 时间选择器 */
                  ElevatedButton(
                    onPressed: () async {
                      final result = await showBoardDateTimePicker(
                        context: context,
                        pickerType: DateTimePickerType.time,
                        options: getBoardDateTimeOptions(context),
                      );

                      if (result != null) {
                        final timeStr =
                            "${result.hour.toString().padLeft(2, '0')}:${result.minute.toString().padLeft(2, '0')}";
                        if (context.mounted) {
                          showTextSnackBar(context, msg: timeStr);
                        }
                      }
                    },
                    child: const Text('时间选择器'),
                  ),

                  /* 日期时间选择器 */
                  ElevatedButton(
                    onPressed: () async {
                      final result = await showBoardDateTimePicker(
                        context: context,
                        pickerType: DateTimePickerType.datetime,
                        initialDate: DateTime.now(),
                        minimumDate: DateTime(2015, 1, 1),
                        maximumDate: DateTime(2028, 1, 1),
                        options: getBoardDateTimeOptions(context),
                      );

                      if (result != null) {
                        final dateTimeStr =
                            "${result.year}-${result.month}-${result.day} "
                            "${result.hour.toString().padLeft(2, '0')}:${result.minute.toString().padLeft(2, '0')}";
                        if (context.mounted) {
                          showTextSnackBar(context, msg: dateTimeStr);
                        }
                      }
                    },
                    child: const Text('日期时间选择器'),
                  ),

                  /* 日期范围选择器 */
                  ElevatedButton(
                    onPressed: () async {
                      final result = await showBoardDateTimeMultiPicker(
                        context: context,
                        pickerType: DateTimePickerType.date,
                        minimumDate: DateTime(2015, 1, 1),
                        maximumDate: DateTime(2028, 1, 1),
                        options: getBoardDateTimeOptions(context),
                      );

                      if (result != null) {
                        final startDateStr =
                            "${result.start.year}-${result.start.month}-${result.start.day}";
                        final endDateStr =
                            "${result.end.year}-${result.end.month}-${result.end.day}";
                        if (context.mounted) {
                          showTextSnackBar(
                            context,
                            msg: "选择的日期范围: $startDateStr 至 $endDateStr",
                          );
                        }
                      }
                    },
                    child: const Text('日期范围选择器'),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
