import 'package:auction_bd24/controller/controllers/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LandingPage extends StatelessWidget {
  LandingPage({super.key});
  final loginController = Get.find<LoginController>();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('Auction Gellary'),
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: GestureDetector(
            onTap: () {
              loginController.googleSignout();
            },
            child: Icon(Icons.logout),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
            child: GestureDetector(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return MyAlertDialog();
                      // AlertDialog(
                      //     content: SizedBox(
                      //         height: height / 3,
                      //         child: Center(
                      //           child: SingleChildScrollView(
                      //             child: Column(
                      //               children: [

                      //               ],
                      //             ),
                      //           ),
                      //         )));
                    });
              },
              child: Icon(Icons.add),
            ),
          )
        ],
      ),
      body: Center(
        child: ElevatedButton(onPressed: () {}, child: Text('logout')),
      ),
    );
  }

  Widget dialogWidget() {
    return Text('data');
  }
}

class MyAlertDialog extends StatefulWidget {
  @override
  _MyAlertDialogState createState() => _MyAlertDialogState();
}

class _MyAlertDialogState extends State<MyAlertDialog> {
  // TextEditingController to handle the date and time fields
  TextEditingController _dateTimeController = TextEditingController();

  // Function to show the date picker
  Future<void> _selectDate(BuildContext context) async {
    DateTime currentDate = DateTime.now();
    print(currentDate);

    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: currentDate,
      firstDate: currentDate.subtract(Duration(days: 365)), // One year ago
      lastDate: currentDate.add(Duration(days: 365)), // One year from now
    );

    if (picked != null && picked != currentDate) {
      // Show the time picker after the date is selected
      _selectTime(context, picked);
    }
  }

  // Function to show the time picker
  Future<void> _selectTime(BuildContext context, DateTime pickedDate) async {
    TimeOfDay currentTime = TimeOfDay.now();

    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: currentTime,
    );

    if (pickedTime != null) {
      // Combine the date and time and update the text field
      DateTime pickedDateTime = DateTime(
        pickedDate.year,
        pickedDate.month,
        pickedDate.day,
        pickedTime.hour,
        pickedTime.minute,
      );

      setState(() {
        _dateTimeController.text = pickedDateTime.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Set Date and Time'),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            TextFormField(
              controller: _dateTimeController,
              onTap: () => _selectDate(context),
              decoration: InputDecoration(
                labelText: 'Date and Time',
                hintText: 'Tap to select date and time',
                prefixIcon: Icon(Icons.calendar_today),
              ),
              readOnly: true,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please select date and time';
                }
                return null;
              },
            ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            // Handle form submission here
            String dateTimeValue = _dateTimeController.text;
            print('Selected date and time: $dateTimeValue');
            Navigator.of(context).pop();
          },
          child: Text('Save'),
        ),
      ],
    );
  }
}
