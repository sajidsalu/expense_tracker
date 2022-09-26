import 'package:expense_tracker/constants/colors.dart';
import 'package:expense_tracker/constants/hive_boxes.dart';
import 'package:expense_tracker/constants/styles.dart';
import 'package:expense_tracker/models/expense_transaction.dart';
import 'package:expense_tracker/models/transaction_categories.dart';
import 'package:expense_tracker/modules/expense/create/bloc.dart';
import 'package:expense_tracker/modules/home/transaction-card.dart';
import 'package:expense_tracker/services/transaction_category.dart';
import 'package:expense_tracker/services/transaction_utils.dart';
import 'package:expense_tracker/services/types/transaction_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_guid/flutter_guid.dart';
import 'package:hive/hive.dart';
 import 'package:intl/intl.dart';
class CreateExpense extends StatefulWidget {
  const CreateExpense({Key? key}) : super(key: key);

  @override
  State<CreateExpense> createState() => _CreateExpenseState();
}

class _CreateExpenseState extends State<CreateExpense> {
  late Box<ExpenseTransaction> dataBox;

  TransactionCategoryService categoryService = TransactionCategoryService();

  TextEditingController amountInput = TextEditingController();
  TextEditingController dateInput = TextEditingController();
  ExpenseTransactionService service = ExpenseTransactionService();

  final amountController = TextEditingController(text: "0");
  final dateController = TextEditingController(text: "today");
  final descriptionController = TextEditingController();
  var selectedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());

  CreateExpenseBloc _bloc = CreateExpenseBloc();

  TransactionCategories selectedCategory = TransactionCategories.food();

  bool isExpense = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dateInput.text = "";
    dataBox = Hive.box<ExpenseTransaction>(HiveBoxes.expenses);

  }

  @override
  void dispose() {
    amountController.dispose();
    dateController.dispose();
    descriptionController.dispose();
    super.dispose();
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
              Row(
                children: [
                  Text("${isExpense ? "Expense":"Income"}", style: TextStyles.h3,),
                  Switch(
                    value: isExpense,
                    onChanged: (value) {
                      setState(() {
                        isExpense = value;
                      });
                    },
                    activeTrackColor: AppColors.coolGrey,
                    activeColor: AppColors.primaryViolet,
                    inactiveThumbColor: AppColors.secondary,
                  ),
                ],
              ),
              Column(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 10,vertical: 20),
                    child:Text("${isExpense ? "Add Expense": "Add Income"}", style: TextStyles.h1Dark,),
                  ),
                  SizedBox(
                    width: 250,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
                      child: TextFormField(
                        controller: amountController,
                        textAlign: TextAlign.center,
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
                          child: StreamBuilder<List<TransactionCategories>>(
                              stream: _bloc.categories,
                              builder: (context, snapshot) {
                                List<TransactionCategories> categories = snapshot.data?? [];
                                print("categories are $categories");
                                return DropdownButtonFormField<TransactionCategories>(
                                  iconSize: 0,
                                  decoration: const InputDecoration(
                                    border: UnderlineInputBorder(),
                                    labelText:"Category",
                                  ),
                                  onChanged: (newVal) {
                                    // This is called when the user selects an item.
                                    setState(() {
                                      selectedCategory = newVal!;
                                    });
                                  },
                                  items: categories.map<DropdownMenuItem<TransactionCategories>>((TransactionCategories value) {
                                    return DropdownMenuItem<TransactionCategories>(
                                      value: value,
                                      child: Text(value.category),
                                    );
                                  }).toList(),
                                );
                              }
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
                            controller: descriptionController,
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
                            controller: dateController,
                            onTap: () async {
                              DateTime? pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(1950),
                                  //DateTime.now() - not to allow to choose before today.
                                  lastDate: DateTime(2100));
                              if (pickedDate != null) {
                                String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                                String today = DateFormat('yyyy-MM-dd').format(DateTime.now());
                                setState(() {
                                  if(formattedDate == today){
                                    dateController.text="today";
                                    selectedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
                                  }else {
                                    dateController.text = formattedDate;
                                  }
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
                  onPressed: () {
                    print('the selected category iss ${selectedCategory}');
                    ExpenseTransaction mData = ExpenseTransaction(
                        description: descriptionController.text,
                        categoryId: selectedCategory.id,
                        amount: double.parse(amountController.text),
                        category: selectedCategory.category.toString(),
                        date: dateController.text.toString(),
                        type: TransactionType.expense.toString(),
                        id: Guid.newGuid.toString(),
                        isExpense: isExpense,
                    );
                    service.insertTransaction(mData);
                  },
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
