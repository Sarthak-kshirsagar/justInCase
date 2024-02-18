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
            Text("BillWise",style: TextStyle(
              fontWeight: FontWeight.bold,fontSize: 18
            ),),
            SizedBox(height: 20,),
            //           InkWell(
            //             onTap: (){
            //               Navigator.push(context, MaterialPageRoute(builder: (context) => CategoriesRender(),));
            //             },
            //             borderRadius: BorderRadius.circular(15),
            //             child: Container(
            //               width:300,
            //               height:80,
            //
            //               child: Center(child: Row(
            //                 mainAxisAlignment: MainAxisAlignment.spaceAround,
            //                 children: [
            //                   Text("Stores & Expense",style: TextStyle(
            //                     fontWeight: FontWeight.bold,fontSize: 22
            //                   ),),
            //                   Icon(Icons.arrow_forward,color: Colors.black,size:30,)
            //                 ],
            //               )),
            //               decoration: BoxDecoration(
            //                   color: Colors.green.shade200,
            //                 // border: Border.all(
            //                 //   color: Colors.black,
            //                 //   width: 1
            //                 // ),
            //                 borderRadius: BorderRadius.circular(15)
            //               ),
            //             ),
            //           ),
            // SizedBox(height: 20,),
            // InkWell(
            //   onTap: (){
            //     Navigator.push(context, MaterialPageRoute(builder: (context) => MonthlyYearlyBarGraph(),));
            //   },
            //   borderRadius: BorderRadius.circular(15),
            //   child: Container(
            //     width:300,
            //     height:80,
            //
            //     child: Center(child: Row(
            //       mainAxisAlignment: MainAxisAlignment.spaceAround,
            //       children: [
            //         Text("Monthly and Yearly",style: TextStyle(
            //             fontWeight: FontWeight.bold,fontSize: 22
            //         ),),
            //         Icon(Icons.arrow_forward,color: Colors.black,size:30,)
            //       ],
            //     )),
            //     decoration: BoxDecoration(
            //         color: Colors.green.shade200,
            //         // border: Border.all(
            //         //   color: Colors.black,
            //         //   width: 1
            //         // ),
            //         borderRadius: BorderRadius.circular(15)
            //     ),
            //   ),
            // ),
            // SizedBox(height: 20,),
            // InkWell(
            //   onTap: (){
            //
            //     Navigator.push(context, MaterialPageRoute(builder: (context) => MonthlyStoreRender(),));
            //   },
            //   borderRadius: BorderRadius.circular(15),
            //   child: Container(
            //     width:300,
            //     height:80,
            //
            //     child: Center(child: Row(
            //       mainAxisAlignment: MainAxisAlignment.spaceAround,
            //       children: [
            //         Text("Categories",style: TextStyle(
            //             fontWeight: FontWeight.bold,fontSize: 22
            //         ),),
            //         Icon(Icons.arrow_forward,color: Colors.black,size:30,)
            //       ],
            //     )),
            //     decoration: BoxDecoration(
            //         color: Colors.green.shade200,
            //         // border: Border.all(
            //         //   color: Colors.black,
            //         //   width: 1
            //         // ),
            //         borderRadius: BorderRadius.circular(15)
            //     ),
            //   ),
            // ),
            // SizedBox(height: 20,),
            ServiceFeature(context,MonthlyStoreRender(),"Categories Expense",Icons.shop,"Have a look at which\n category you spend more money :)")
            ,SizedBox(height: 15,),
        SizedBox(height: 15,),
          ServiceFeature(context,CategoriesRender(),"Store Expense",Icons.category,"Have a look at which\n store you spend more money :)")
    ,SizedBox(height: 15,),
    ServiceFeature(context,MonthlyYearlyBarGraph(),"Monthly & Yearly",Icons.calendar_month,"Visualize all the expenses")


          ],
        ),
      )),
    );
  }
  Widget ServiceFeature(BuildContext ctx,Widget w,String header,IconData icon,String Content){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: (){
          Navigator.push(ctx, MaterialPageRoute(builder: (context) => w,));
        },
        child: Container(
          width:double.infinity,
          height:100,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),border: Border.all(color: Colors.black,width: 2)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(icon,color: Colors.black,size: 30,),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(header,style: TextStyle(fontWeight: FontWeight.bold,fontSize:18),),
                    SizedBox(height: 10,),
                    Text(textAlign: TextAlign.center,Content,style: TextStyle(fontSize:15),),
                  ],
                ),

                Icon(Icons.arrow_forward_ios_sharp,color: Colors.black,),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
