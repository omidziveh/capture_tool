import 'package:capture_tool/style.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  var times = [15, 30, 60];
  ValueNotifier<int> index = ValueNotifier(0);
  @override
  Widget build(BuildContext context) {
    print('${index.value}');
    for (int i = 0; i < times.length; i++) {
      if (Hive.box('Calendar').get('timeStep') == times[i]) {
        setState(() {
          index.value = i;
        });
      }
    }
    return ValueListenableBuilder(
        valueListenable: index,
        builder: (context, val, _) {
          print('changed');
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: ListView(
              children: [
                settingTile(
                  Row(
                    children: [
                      Padding(padding: EdgeInsets.only(left: 10)),
                      Text(
                        times[index.value].toString().toPersianDigit(),
                        style: profileTextStyle,
                      ),
                      Spacer(),
                      Text(
                        'فاصله زمانی تقویم',
                        style: profileTextStyle,
                      ),
                      Padding(padding: EdgeInsets.only(left: 10)),
                    ],
                  ),
                  () {
                    setState(() {
                      index.value == 2 ? index.value = 0 : index.value++;
                      Hive.box('Calendar').put('timeStep', times[index.value]);
                    });
                  },
                ),
                Container(
                  height: 100,
                )
              ],
            ),
          );
        });
  }

//   void changeTimeStep(BuildContext context) {
//     var names = [
//       15.toString().toPersianDigit(),
//       30.toString().toPersianDigit(),
//       60.toString().toPersianDigit(),
//     ];
//     var times = [15, 30, 60];
//     Object? time = timeStep;
//     int index = 0;
//     for (int i in times) {
//       if (i == index) {
//         index = i;
//         break;
//       }
//     }
//     showBottom(
//       context: context,
//       builder: (BuildContext context) {
//         return Container(
//           color: Colors.white,
//           height: 400,
//           child: SelectWidget(
//             names: names,
//             onChanged: (val) {
//               setState(() {
//                 index = val;
//                 Navigator.pop(context);
//               });
//             },
//             value: index,
//           ),
//         );
//       },
//     );
//   }
// }

  Widget settingTile(child, onTap) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 75,
          decoration: BoxDecoration(
            color: Color.fromRGBO(0, 0, 0, 0.2),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Center(
            child: child,
          ),
        ),
      ),
    );
  }
}
