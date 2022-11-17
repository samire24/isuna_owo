import 'package:flutter/material.dart';

class BarChart extends StatelessWidget {
  final List<double> expenses;

  BarChart(this.expenses);

  @override
  Widget build(BuildContext context) {
    double mostExpensive =0;
    expenses.forEach((double price) {
      if(price > mostExpensive){
        mostExpensive = price;
      }
    });
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: Column(
        children: [
          const Text(
            'Weekly Spending',
            style: TextStyle(
                letterSpacing: 1.2, fontWeight: FontWeight.bold, fontSize: 20),
          ),
          const SizedBox(
            height: 5.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {},
                iconSize: 30.0,
              ),
              const Text(
                'Nov 10,2019-Nov 16, 2019',
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 18.0,
                    letterSpacing: 1.2),
              ),
              IconButton(
                icon: Icon(Icons.arrow_forward),
                onPressed: () {},
                iconSize: 30,
              ),
            ],
          ),
          SizedBox(height: 30,),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Bar(
                label: 'su',
                amountSpent: expenses[0],
                mostExpensive: mostExpensive,
              ),
              Bar(
                label: 'Mon',
                amountSpent: expenses[1],
                mostExpensive: mostExpensive,
              ),
              Bar(
                label: 'Tue',
                amountSpent: expenses[2],
                mostExpensive: mostExpensive,
              ),
              Bar(
                label: 'Wed',
                amountSpent: expenses[3],
                mostExpensive: mostExpensive,
              ),
              Bar(
                label: 'Thur',
                amountSpent: expenses[4],
                mostExpensive: mostExpensive,
              ),
              Bar(
                label: 'Fri',
                amountSpent: expenses[5],
                mostExpensive: mostExpensive,
              ),
              Bar(
                label: 'Sat',
                amountSpent: expenses[6],
                mostExpensive: mostExpensive,
              ),
            ],
          )
        ],
      ),
    );
  }
}

class Bar extends StatelessWidget {
  String label;
  final double amountSpent;
  final double mostExpensive;
  final double _maxBarHeight =150.0;
  Bar({ required this.label,required this.amountSpent,required this.mostExpensive,});

  @override
  Widget build(BuildContext context) {
    final barHeight = amountSpent / mostExpensive * _maxBarHeight;
    return Column(
      children: [
        Text('\$${amountSpent.toStringAsFixed(2)}', style: TextStyle(fontWeight: FontWeight.w600),),
        Container(
          width: 18.0,
          height: barHeight,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(6.0),
          ),
        ),
        SizedBox(height: 8.0,),
        Text(label, style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.w600)),
      ],
    );
  }
}

