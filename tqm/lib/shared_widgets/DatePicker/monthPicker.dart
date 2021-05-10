
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



class MonthPickerWidget extends StatefulWidget{
final Function onChange;

  const MonthPickerWidget({Key key, this.onChange}) : super(key: key);

  @override
  _MonthPickerWidgetState createState() => _MonthPickerWidgetState();
}

class _MonthPickerWidgetState extends State<MonthPickerWidget> {
  


List<MonthModel> mo=[
     new  MonthModel(1,'يناير'),
     new  MonthModel(2,'فبراير'),
     new  MonthModel(3,'مارس'),
     new  MonthModel(4,'ابريل'), 
     new  MonthModel(5,'مايو'), 
     new  MonthModel(6,'يونيو'),
    new  MonthModel(7,'يوليو'),  
    new  MonthModel(8,'اغسطس'), 
    new  MonthModel(9,'سبتمبر'),
     new  MonthModel(10, 'اكتوبر'),
     new  MonthModel(11, 'نوفمبر'), 
     new  MonthModel(12,'ديسمبر')
  ];

MonthModel _selecteValue=new  MonthModel(1,'يناير');

showPicker(context)
{
  

  return showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return 
                          
                          Column(
                            children: [
                              Padding(padding: EdgeInsets.symmetric(horizontal: 5 , vertical: 10) ,

                              child: Text( 'بداية فترة الإستراتيجية -شهور'),
                              ),


                              Expanded(
                                                              child: CupertinoPicker(
                                    itemExtent: 40.0,
                                    onSelectedItemChanged: (index) {
                                      setState(() {
                                         _selecteValue=mo[index];
                                      });
                                     widget.onChange(_selecteValue.number);
                                    },
                                    diameterRatio: 400.0,
                                    useMagnifier: false,
                                    magnification: 1.0,
                                    looping: false,
                                    backgroundColor: Colors.white,
                                    offAxisFraction: 1.0,
                                   
                                    children: [
                                      for(int i=0;i<mo.length;i++)

                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text('$i'),
                                            Text('${mo[i]}')

                                          ],
                                        ),

                                      
                                    ]),
                              ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                    FlatButton(onPressed: (){}, child: Text('موافق')),
                                    SizedBox(width: 8,),
                                     FlatButton(onPressed: (){}, child: Text('الغاء'))
                                  ],)
                            ],
                          );
                        });

}

  @override
  Widget build(BuildContext context) {
    return InkWell(
  onTap: (){
    showPicker(context);
  },
  
  child: 
  
  Text('${_selecteValue.number} - ${_selecteValue.name}'),
);
  }
}



class MonthModel{
  final int number;
  final String name;

  MonthModel(this.number, this.name);


}

//
///
///
///