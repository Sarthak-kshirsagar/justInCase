import 'package:flutter/material.dart';

class Service2 extends StatefulWidget {
  const Service2({super.key});

  @override
  State<Service2> createState() => _Service2State();
}

class _Service2State extends State<Service2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child:Stack(
            children: [
              Image.asset(fit: BoxFit.cover,"assets/dashboard.jpg"),
              ClipRRect(
                child: Align(
                  alignment: Alignment.center,
                  child: FractionalTranslation(
                    translation: Offset(0.0, 0.40),
                    child: Container(
                      width:double.infinity,
                      height:500,
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.only(topLeft:Radius.circular(70),topRight: Radius.circular(70)),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(height: 30,),
                          Text("Financial Analytics Dashboard",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),),
                          SizedBox(height:20,),
                          ListTile(
                            leading: Icon(Icons.receipt_long,color: Colors.black),
                            title: Text("Insightful dashboards for comprehensive financial analysis.",style: TextStyle(fontWeight: FontWeight.bold),),
                          ),
                          ListTile(
                            leading: Icon(Icons.history_edu_rounded,color: Colors.black),
                            title: Text("Dynamic visualizations portraying spending patterns and savings",style: TextStyle(fontWeight: FontWeight.bold),),
                          ),
                          ListTile(
                            leading: Icon(Icons.history_edu_rounded,color: Colors.black),
                            title: Text("Budgeting tools and savings tracking for informed financial decisions",style: TextStyle(fontWeight: FontWeight.bold),),
                          ),
                          // Container(
                          //   padding: EdgeInsets.all(10),
                          //   width: double.infinity,
                          //   child: ElevatedButton(onPressed: (){
                          //
                          //     Navigator.push(context, MaterialPageRoute(builder: (context) => InvoiceList(),));
                          //   },
                          //
                          //       style: ButtonStyle(foregroundColor: MaterialStatePropertyAll(Colors.white),backgroundColor: MaterialStatePropertyAll(Colors.black)),
                          //       child:Row(
                          //         mainAxisAlignment: MainAxisAlignment.end,
                          //         children: [
                          //
                          //           Text("Proceed",textAlign:TextAlign.center),
                          //           SizedBox(width:110,),
                          //           Icon(Icons.forward_rounded),
                          //         ],
                          //       )),
                          // )
                        ],
                      ),
                    ),
                  ),
                ),
              ),

            ],
          )
      ),
    );
  }
}
