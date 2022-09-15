import 'package:expense_tracker/constants/colors.dart';
import 'package:expense_tracker/constants/styles.dart';
import 'package:flutter/material.dart';

class DashboardCard extends StatefulWidget {
  const DashboardCard({Key? key}) : super(key: key);

  @override
  State<DashboardCard> createState() => _DashboardCardState();
}

class _DashboardCardState extends State<DashboardCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
          height: 150,
          width: 50,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              gradient: const LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  AppColors.primaryBlue,
                  AppColors.primaryRed,
                  AppColors.primaryViolet,
                ],
              )
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children:[
                Text("Total Balance",style: TextStyles.h5),
                Text("\$20,000",style: TextStyles.h1),
                Padding(
                  padding: EdgeInsets.only(left: 20,right: 20),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Income",style: TextStyle(color: AppColors.white),),
                          Text("\$2000",style: TextStyle(color: AppColors.white, fontSize: 18),),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Expense",style: TextStyle(color: AppColors.white),),
                          Text("\$2000",style: TextStyle(color: AppColors.white,fontSize: 18),),
                        ],
                      )
                    ],
                  ),
                )
              ] ,
            ),
          ),
        );
  }
}
