import 'package:flutter/material.dart';
import 'package:projecthack/Sections/Stats/StatsRender/shopMonthly.dart';

import 'StatsRender/categoriesRender.dart';
import 'StatsRender/monthlyYearlyBarGraph.dart';

class Statistics extends StatefulWidget {
  const Statistics({super.key});

  @override
  State<Statistics> createState() => _StatisticsState();
}

class _StatisticsState extends State<Statistics> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
                      InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => CategoriesRender(),));
                        },
                        borderRadius: BorderRadius.circular(15),
                        child: Container(
                          width:300,
                          height:80,

                          child: Center(child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text("Categories",style: TextStyle(
                                fontWeight: FontWeight.bold,fontSize: 22
                              ),),
                              Icon(Icons.arrow_forward,color: Colors.black,size:30,)
                            ],
                          )),
                          decoration: BoxDecoration(
                              color: Colors.green.shade200,
                            // border: Border.all(
                            //   color: Colors.black,
                            //   width: 1
                            // ),
                            borderRadius: BorderRadius.circular(15)
                          ),
                        ),
                      ),
            SizedBox(height: 20,),
            InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => MonthlyYearlyBarGraph(),));
              },
              borderRadius: BorderRadius.circular(15),
              child: Container(
                width:300,
                height:80,

                child: Center(child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text("Monthly and Yearly",style: TextStyle(
                        fontWeight: FontWeight.bold,fontSize: 22
                    ),),
                    Icon(Icons.arrow_forward,color: Colors.black,size:30,)
                  ],
                )),
                decoration: BoxDecoration(
                    color: Colors.green.shade200,
                    // border: Border.all(
                    //   color: Colors.black,
                    //   width: 1
                    // ),
                    borderRadius: BorderRadius.circular(15)
                ),
              ),
            ),
            SizedBox(height: 20,),
            InkWell(
              onTap: (){

                Navigator.push(context, MaterialPageRoute(builder: (context) => MonthlyStoreRender(),));
              },
              borderRadius: BorderRadius.circular(15),
              child: Container(
                width:300,
                height:80,

                child: Center(child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text("Stores Monthly",style: TextStyle(
                        fontWeight: FontWeight.bold,fontSize: 22
                    ),),
                    Icon(Icons.arrow_forward,color: Colors.black,size:30,)
                  ],
                )),
                decoration: BoxDecoration(
                    color: Colors.green.shade200,
                    // border: Border.all(
                    //   color: Colors.black,
                    //   width: 1
                    // ),
                    borderRadius: BorderRadius.circular(15)
                ),
              ),
            ),
            SizedBox(height: 20,),
          ],
        ),
      )),
    );
  }
}
