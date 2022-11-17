import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:isuna_owo/data/data.dart';
import 'package:isuna_owo/helpers/colors.dart';
import 'package:isuna_owo/models/category_model.dart';
import 'package:isuna_owo/models/expense_model.dart';
import 'package:isuna_owo/screen/categoryScreen.dart';
import 'package:isuna_owo/widget/barchart.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  _buildCategory(Category category, double totalAmountSpent) {
    return Container(
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      height: 100,
      width: double.infinity,
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(10),
              color: Colors.white,
              boxShadow: const [
        BoxShadow(
          offset: Offset(0.0, 2.0),
          color: Colors.black12,
          blurRadius: 6.0,
        ),
      ]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                category.name,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                '\$${(category.maxAmount - totalAmountSpent).toStringAsFixed(2)} /  \$${category.maxAmount.toStringAsFixed(2)}',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
              )
            ],
          ),
          SizedBox(height: 10,),
          LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              final double maxBarWidth = constraints.maxWidth;
              final double percent = (category.maxAmount - totalAmountSpent)/ category.maxAmount;
              double barWidth = percent*maxBarWidth;
              if(barWidth < 0){
                barWidth = 0;
              }
              return GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (_)=>CategoryScreen(category)));
                },
                child: Stack(
                  children: [
                    Container(
                      height: 20,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.grey[200]
                      ),
                    ),
                    Container(
                      height: 20,
                      width: barWidth,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: getColors(context, percent),
                      ),
                    ),
                  ],
                ),
              );
            }
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            forceElevated: true,
            floating: true,
            // snap: false,
            backgroundColor: Theme.of(context).primaryColor,
            // pinned: true,
            expandedHeight: 100.0,
            leading: IconButton(
                icon: Icon(Icons.settings), iconSize: 30.0, onPressed: () {}),
            flexibleSpace: const FlexibleSpaceBar(
              title: Text('Simple Budget'),
            ),
            actions: [
              IconButton(icon: Icon(Icons.add), iconSize: 30, onPressed: () {}),
            ],
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                if (index == 0) {
                  return Container(
                    margin: EdgeInsets.fromLTRB(20, 20, 20, 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                          offset: Offset(0, 2),
                          color: Colors.black12,
                          blurRadius: 6.0,
                        ),
                      ],
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: BarChart(weeklySpending),
                  );
                } else {
                  final Category category = categories[index - 1];
                  double totalAmountSpent = 0;
                  category.expenses.forEach((Expense expense) {
                    totalAmountSpent += expense.cost;
                  });
                  return _buildCategory(category, totalAmountSpent);
                }
              },
              childCount: 1 + categories.length,
            ),
          )
        ],
      ),
    );
  }
}
