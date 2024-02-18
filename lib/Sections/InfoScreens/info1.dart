import 'package:flutter/material.dart';

class Service1 extends StatefulWidget {
  const Service1({super.key});

  @override
  State<Service1> createState() => _Service1State();
}

class _Service1State extends State<Service1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child:Stack(
            children: [
              Image.asset(fit: BoxFit.cover,"assets/ExpenseT.jpg"),
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
                          Text("Expense Tracking and Categorization",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),),
                          SizedBox(height:20,),
                          ListTile(
                            leading: Icon(Icons.receipt_long,color: Colors.black),
                            title: Text("Efficiently manage and categorize daily expenses",style: TextStyle(fontWeight: FontWeight.bold),),
                          ),
                          ListTile(
                            leading: Icon(Icons.history_edu_rounded,color: Colors.black),
                            title: Text("Streamlined expense tracking with customizable categories",style: TextStyle(fontWeight: FontWeight.bold),),
                          ),
                          ListTile(
                            leading: Icon(Icons.receipt_long,color: Colors.black),
                            title: Text("Secure storage of expense data for accurate financial records",style: TextStyle(fontWeight: FontWeight.bold),),
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
