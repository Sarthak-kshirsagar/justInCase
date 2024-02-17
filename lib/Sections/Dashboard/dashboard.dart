import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:info_popup/info_popup.dart';
import 'package:info_widget/info_widget.dart';

import '../Porfile/helpSection.dart';

class DashboardUi extends StatefulWidget {
  const DashboardUi({super.key});

  @override
  State<DashboardUi> createState() => _DashboardUiState();
}

class _DashboardUiState extends State<DashboardUi> {
  final List<HelpContent> helpContents = [
    HelpContent(
      question: 'How to add customers?',
      answer: 'Navigate to the home, then go to customer management, and finally, add a new customer.',
    ),
    HelpContent(
      question: 'How to manage payments?',
      answer: 'Navigate to the home, then go to payment management, and finally, update.',
    ),
    HelpContent(
      question: 'How to generate and share invoices?',
      answer: 'Navigate to billing and invoicing, then select customers according to your needs using the dropdown. Next, click on "View Bill," followed by "View Receipt," and finally, click on "Share."',
    ),

    // Add more help contents as needed
  ];
  @override
  Widget build(BuildContext context) {

    return Scaffold(


            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                              SizedBox(height: 20,),   //for header
                      Container(
                        child:Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Align(
                              alignment:Alignment.centerLeft,
                              child: Container(
                                width: 80,
                                height: 80,
                                child: CircleAvatar(
                                  radius: 30,
                                  backgroundImage: AssetImage("assets/profilePic.jpg"),
                                ),
                                decoration: BoxDecoration(
                                  // color: Colors.grey,
                                ),
                              ),
                            ),
                            SizedBox(width:30,),
                            Text("Home",style: TextStyle(
                              fontWeight: FontWeight.bold,fontSize:20,
                            ),),
                            SizedBox(width:30,),
                  
                            Icon(Icons.notification_add,color: Colors.black,size:30,),
                          ],
                        )
                      ),
                      //for main card
                    SizedBox(height: 50,),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Material(
                          elevation: 42,
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(20),
                  
                          // color: Colors.black87,
                          child: Container(
                            width:400,
                            height: 200,
                            decoration: BoxDecoration(
                              color: Colors.black87,
                                border: Border.all(
                                  color: Colors.black,
                                  width: 1.5,
                  
                                ),
                              borderRadius: BorderRadius.circular(20)
                            ),
                            child:Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text("Available Balance",style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18
                                  ),),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text("25000",style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 30
                                  ),),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Sarthak Kshirsagar",style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16
                                      ),),
                                      Icon(Icons.account_balance,size: 50,color: Colors.white,)
                                    ],
                                  ),
                                )
                  
                              ],
                            )
                          ),
                        ),
                      ),

              SizedBox(height: 20,),
                      //for daily statistics
                      SizedBox(height: 20,),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Prediction",style:TextStyle(
                                fontWeight: FontWeight.bold,fontSize: 22,
                              ),),
                              SizedBox(width: 20,),
                              InfoPopupWidget(
                                contentTitle: 'Based on ARIMA using\nlast 5 transactions',
                                child: Icon(
                                  Icons.help,
                                  color: Colors.pink,
                                ),
                              ),

                            ]
                            ,
                          ),
                        ),
                      ),
                      SizedBox(height: 20,),
                      Container(
                        width: 250,
                        height: 250,
                        color: Colors.grey,
                        child: Image.asset("assets/graphImage.png"),
                      ),
                      SizedBox(height: 20,),
                      Container(
                        width: 450,
                        height: 120,

                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                             showExpenses(Colors.purple.shade200,Icons.group,"Daily Expense", "850"),
                              SizedBox(width: 20,),
                              showExpenses(Colors.red.shade100,Icons.calendar_month,"Monthly Expense", "850"),
                              SizedBox(width: 20,),
                              showExpenses(Colors.green.shade100,Icons.money,"Yealry Expense", "850"),

                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 20,),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text("Our Services",style:TextStyle(
                          fontWeight: FontWeight.bold,fontSize: 22,
                        ),),
                      ),
                      Container(
                        width: 350,
                        height: 500,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              explore(context,"assets/profilePic.jpg","Customer Management","Effortlessly organize and track student information with our intuitive management system.",DashboardUi()),
                              explore(context,"assets/profilePic.jpg","Customer Management","Effortlessly organize and track student information with our intuitive management system.",DashboardUi()),

                              explore(context,"assets/profilePic.jpg","Customer Management","Effortlessly organize and track student information with our intuitive management system.",DashboardUi()),

                              explore(context,"assets/profilePic.jpg","Customer Management","Effortlessly organize and track student information with our intuitive management system.",DashboardUi()),


                            ],
                          ),
                        ),
                      )
                                           // Container(
                      //   width: 300,
                      //   height: 100,
                      //   color: Colors.red.shade200,
                      //   child: SingleChildScrollView(
                      //     scrollDirection: Axis.horizontal,
                      //     child: Row(
                      //       // mainAxisAlignment: MainAxisAlignment.spaceAround,
                      //       children: [
                      //         SizedBox(width:20,),
                      //         Container(
                      //           width: 50,
                      //           height: 50,
                      //           color: Colors.white,
                      //
                      //         ),
                      //         SizedBox(width:20,),
                      //         Container(
                      //           width: 50,
                      //           height: 50,
                      //           color: Colors.white,
                      //
                      //         ),
                      //         SizedBox(width:20,),
                      //         Container(
                      //           width: 50,
                      //           height: 50,
                      //           color: Colors.white,
                      //
                      //         ),
                      //       ],
                      //     ),
                      //   ),
                      // )
                      ,SizedBox(height:20,),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            textAlign: TextAlign.center,
                            "Help",
                            style: TextStyle(
                              fontSize:20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 25,),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height:500,
                        child: ListView.builder(
                          itemCount: helpContents.length,
                          itemBuilder: (context, index) {
                            return HelpExpansionTile(helpContent: helpContents[index]);
                          },
                        ),
                      ),


                    ],
                  ),
                ),
              ),
            ),
    );

  }
  Widget showExpenses(Color c1,IconData i,heading,money){
    return  Material(

      // elevation: 20,
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(15),
      child: InkWell(
        onTap: (){},

        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: 150,
            height: 100,
            decoration: BoxDecoration(
                color: c1,
                borderRadius: BorderRadius.circular(15)
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                 Icon(i,color: Colors.black,),
                  Text("${money}",style:TextStyle(
                    fontWeight: FontWeight.bold,fontSize: 22,
                  ),),
                  Text("${heading}",style:TextStyle(
                    fontWeight: FontWeight.bold,fontSize:15,
                  ),),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  Widget explore(BuildContext context,String path,String heading,String Content,Widget Route){
    return InkWell(
      onTap: (){

        Navigator.of(context).push(MaterialPageRoute(builder: (context) => Route));
      },
      child: Padding(

        padding: const EdgeInsets.all(10.0),
        child: Container(
          height: 400,
          decoration: BoxDecoration(
            boxShadow:[
              BoxShadow(color: Colors.grey,offset:Offset(0,0),blurRadius:8,spreadRadius:0,blurStyle: BlurStyle.outer),                  ],
            // border: Border.all(color: Colors.black,width: 1),
            borderRadius: BorderRadius.only(topLeft: Radius.circular(00),topRight:Radius.circular(70),bottomLeft: Radius.circular(30)),
          ),
          width:250,
          // height:200,
          child:Column(

            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRRect(borderRadius: BorderRadius.only(topLeft: Radius.circular(00),topRight:Radius.circular(70),bottomLeft:Radius.circular(0)),child: Image.asset(fit: BoxFit.fitWidth,height: 250,width:250,path)),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(heading,style: TextStyle(fontWeight: FontWeight.bold,fontSize:15),),
                    SizedBox(width:10,),
                    Icon(Icons.arrow_forward,size:30,),
                  ],

                ),
              ),

              Padding(

                padding: const EdgeInsets.all(20.0),
                child: SizedBox(
                    height:70,
                    child: Text(Content,style:TextStyle(fontSize:15,))),
              ),

            ],
          ) ,
        ),
      ),
    );
  }
}
