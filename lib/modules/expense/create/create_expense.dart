import 'package:expense_tracker/constants/colors.dart';
import 'package:expense_tracker/constants/styles.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
class CreateExpense extends StatefulWidget {
  const CreateExpense({Key? key}) : super(key: key);

  @override
  State<CreateExpense> createState() => _CreateExpenseState();
}

class _CreateExpenseState extends State<CreateExpense> {
  List<String> list = <String>['Home Rent', 'Entertainment', 'Bills','Recharge','food'];
  String dropdownValue = "";
  TextEditingController dateInput = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dropdownValue = list.first;
    dateInput.text = "";
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset : false,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 10,vertical: 20),
                    child:Text("Add Expense", style: TextStyles.h1Dark,),
                  ),
                  SizedBox(
                    width: 250,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
                      child: TextFormField(
                        textAlign: TextAlign.center,
                        initialValue: '0',
                        maxLines: 1,
                        keyboardType: TextInputType.number,
                        style: const TextStyle(fontSize: 40),
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(50))),
                          prefix: Text("\$"),
                          prefixStyle: TextStyle(fontSize: 20, color:AppColors.grey),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                    child: Row(
                      children: [
                        Image.asset("assets/images/category.png",height: 20,width: 20,),
                        SizedBox(width: 20,),
                        Expanded(
                          child: DropdownButtonFormField<String>(
                            iconSize: 0,
                            value: dropdownValue,
                            decoration: const InputDecoration(
                              border: UnderlineInputBorder(),
                              labelText:"Category",
                            ),
                            onChanged: (String? value) {
                              // This is called when the user selects an item.
                              setState(() {
                                dropdownValue = value!;
                              });
                            },
                            items: list.map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                    child: Row(
                      children: [
                        Image.asset("assets/images/edit-info.png",height: 25,width: 25,),
                        SizedBox(width: 20,),
                        Expanded(
                          child: TextFormField(
                            decoration: const InputDecoration(
                              border: UnderlineInputBorder(),
                              labelText: 'note',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                    child: Row(
                      children: [
                        Image.asset("assets/images/calendar.png",height: 20,width: 20,),
                        SizedBox(width: 20,),
                        Expanded(
                          child: TextFormField(
                              controller: dateInput,
                            onTap: () async {
                              DateTime? pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(1950),
                                  //DateTime.now() - not to allow to choose before today.
                                  lastDate: DateTime(2100));

                              if (pickedDate != null) {
                                String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                                setState(() {
                                  dateInput.text =
                                      formattedDate; //set output date to TextField value.
                                });
                              } else {}
                            },
                            textInputAction: TextInputAction.none,
                            keyboardType: TextInputType.none,
                            readOnly: true,
                            decoration: const InputDecoration(
                              border: UnderlineInputBorder(),
                              labelText: 'Date',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ]
              ),
              SizedBox(
                width: 250,
                height: 60,
                child: ElevatedButton(
                  style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              AppColors.primaryRed),
                          foregroundColor: MaterialStateProperty.all<Color>(
                              AppColors.white),
                  ),
                  onPressed: () {},
                  child: const Text('Save'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
