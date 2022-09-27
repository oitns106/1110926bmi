import 'package:flutter/material.dart';

void main()=>runApp(myApp());

class myApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(theme: ThemeData(primaryColor: Colors.pinkAccent) ,home: demo(),);
  }
}

class demo extends StatefulWidget {
  @override
  demoState createState() => demoState();
}

class demoState extends State<demo> {

  TextEditingController heightController=TextEditingController();
  TextEditingController weightController=TextEditingController();
  double? result1;
  String? bmi_status;
  bool validateh=false, validatew=false;
  bool visible1=true;

  Color? getTextColor(String? s1) {
    if (s1=="正常~") {  return Colors.green;   }
    else if (s1=="過輕...") {  return Colors.amberAccent;   }
    else if (s1=="過重!") {  return Colors.redAccent;   }
  }

  @override
  void dispose() {
    heightController.dispose();
    weightController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text("BMI計算機"),
      centerTitle: true,
      backgroundColor: Colors.greenAccent,),
      body:
          ListView(
            padding:EdgeInsets.only(top:50, left:10, right:10),
            children: <Widget> [
          Container(
          padding: EdgeInsets.symmetric(horizontal: 30.0),
          color:Colors.grey.shade300,
          child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: heightController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: '請輸入身高',
                hintText: 'cm',
                errorText: validateh? "不得為空":null,
                icon: Icon(Icons.trending_up),
              ),
              style: TextStyle(fontSize: 22),
            ),
            SizedBox(height: 20),
            TextField(
              controller: weightController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: '請輸入體重',
                hintText: 'Kg',
                errorText: validatew? "不得為空":null,
                icon: Icon(Icons.trending_down),
              ),
              style: TextStyle(fontSize: 22),
            ),
            SizedBox(height: 15),
            ElevatedButton(
              child: Text("計算", style: TextStyle(color: Colors.white),),
              onPressed: () {
                setState(() {
                  heightController.text.isEmpty? validateh=true:validateh=false;
                  weightController.text.isEmpty? validatew=true:validatew=false;
                  visible1=(validateh || validatew)? false:true;
                });
                calculateBMI(); },
              style: ElevatedButton.styleFrom(textStyle: TextStyle(fontSize: 20)),
            ),
            SizedBox(height: 15),
           ]
          )
          ),
          SizedBox(height: 15),

          Visibility(
            visible: visible1,
            child:
                  Container(
                            padding: EdgeInsets.symmetric(horizontal: 30.0),
                            child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: <Widget>[
                                                            Text(
                                                                 result1==null? "":"您的BMI值=${result1?.toStringAsFixed(2)}",
                                                                 style: TextStyle(color:Colors.blueAccent,
                                                                 fontSize: 22,
                                                                 fontWeight: FontWeight.w500),
                                                                ),
                                                            SizedBox(height: 15),
                                                            RichText(text: TextSpan(style:TextStyle(color: Colors.blueAccent,
                                                                     fontSize: 22,
                                                                     fontWeight: FontWeight.w500),
                                                                     children:<TextSpan>[
                                                                              TextSpan(text: bmi_status==null? "":"您的體重狀態為："),
                                                                              TextSpan(text: bmi_status==null? "":"$bmi_status",
                                                                              style:TextStyle(color: getTextColor(bmi_status),
                                                                              fontWeight: FontWeight.bold)),
                                                                              ],),
                                                            ),
                                                           ],
                                        ),
                           ),
          ),
          ],
          ),
    );
  }
  void calculateBMI() {
    if (heightController.text!="" && weightController.text!="") {
     setState(() {
      double h=double.parse(heightController.text)/100;
      double w=double.parse(weightController.text);
      result1=w/(h*h);
      if (result1!<18.5) {
        bmi_status="過輕...";
      }
      else if (result1!>25) {
        bmi_status="過重!";
      }
      else { bmi_status="正常~"; }
    });
  }
    else {
      setState(() {
        result1=null;
        bmi_status=null;
      });
      showDialog(context: context, builder:(context) {
        return AlertDialog(title:Text("警告"),
                           content:Text("身高體重不得為空!"),
                           actions:<Widget>[
                             TextButton(onPressed: ()=>Navigator.pop(context),
                                        child: Text("了解"),)
                           ],);
      });
    }
  }
}