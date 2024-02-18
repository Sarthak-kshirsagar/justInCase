import 'package:flutter/material.dart';

class Service3 extends StatefulWidget {
  const Service3({super.key});

  @override
  State<Service3> createState() => _Service3State();
}

class _Service3State extends State<Service3> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child:Stack(
            children: [
              Image.asset(fit: BoxFit.cover,"assets/chatbotIm.jpg"),
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
                          Text("Financial Literacy Hub",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),),
                          SizedBox(height:20,),
                          ListTile(
                            leading: Icon(Icons.receipt_long,color: Colors.black),
                            title: Text("Holistic financial education platform for enhanced literacy",style: TextStyle(fontWeight: FontWeight.bold),),
                          ),
                          ListTile(
                            leading: Icon(Icons.history_edu_rounded,color: Colors.black),
                            title: Text("Proactive financial tips and personalized advice.",style: TextStyle(fontWeight: FontWeight.bold),),
                          ),
                          ListTile(
                            leading: Icon(Icons.history_edu_rounded,color: Colors.black),
                            title: Text("Interactive chatbot providing tailored financial insights and recommendations",style: TextStyle(fontWeight: FontWeight.bold),),
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
