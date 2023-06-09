import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../colors/colors.dart';

// import '../wepveiw/webveiw.dart';

Widget myIconButtom({
  void Function()? f,
  required IconData icon,
}) {
  return Container(
    height: 56,
    width: 56,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(5),
      color: defultButtomColor,
    ),
    child: IconButton(
      onPressed: f,
      icon: Icon(icon, color: Colors.white),
    ),
  );
}

// Print Long String
void printLongString(String text) {
  final RegExp pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
  pattern
      .allMatches(text)
      .forEach((RegExpMatch match) => print(match.group(0)));
}

Widget myToggelButtom() {
  List<bool> isSelected = [true, false, false];
  return ToggleButtons(
      // list of booleans
      isSelected: isSelected,
      // text color of selected toggle
      selectedColor: Colors.white,
      // text color of not selected toggle
      color: Colors.blue,
      // fill color of selected toggle
      fillColor: Colors.lightBlue.shade900,
      // when pressed, splash color is seen
      splashColor: Colors.red,
      // long press to identify highlight color
      highlightColor: Colors.orange,
      // if consistency is needed for all text style
      textStyle: const TextStyle(fontWeight: FontWeight.bold),
      // border properties for each toggle
      renderBorder: true,
      borderColor: Colors.black,
      borderWidth: 1.5,
      borderRadius: BorderRadius.circular(10),
      selectedBorderColor: Colors.pink,
// add widgets for which the users need to toggle
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: Text('MALE', style: TextStyle(fontSize: 18)),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: Text('FEMALE', style: TextStyle(fontSize: 18)),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: Text('OTHER', style: TextStyle(fontSize: 18)),
        ),
      ],
// to select or deselect when pressed
      onPressed: (int newIndex) {
        // looping through the list of booleans values
        for (int index = 0; index < isSelected.length; index++) {
          // checking for the index value
          if (index == newIndex) {
            // one button is always set to true
            isSelected[index] = true;
          } else {
            // other two will be set to false and not selected
            isSelected[index] = false;
          }
        }
      });
}

Widget Mybtn({
  double width = double.infinity,
  double? height,
  Color? color = Colors.blue,
  void Function()? todo,
  required String? text,
  Color? textcolor = Colors.white,
  double? borderRedius = 0,
}) =>
    Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRedius!), color: color),
      width: width,
      height: height,
      child: MaterialButton(
        onPressed: todo,
        child: Text(
          text!,
          style: TextStyle(color: textcolor),
        ),
      ),
    );

Widget MyTff({
  TextEditingController? TffID,
  TextInputType? keyboardfor,
  void Function(String)? onsubmit,
  void Function(String)? onchange,
  void Function()? ontap,
  void Function()? suffexpress,
  String? hint,
  String? lable,
  double? radius = 0,
  Icon? preicon,
  IconData? posticon,
  bool security = false,
  String? isEmpty,
  bool enable=true,
}) =>
    TextFormField(
      enabled: enable,
        controller: TffID,
        keyboardType: keyboardfor,
        onFieldSubmitted: onsubmit,
        obscureText: security,
        onChanged: onchange,
        onTap: ontap,
        validator: (value) {
          if (value!.isEmpty) {
            return isEmpty;
          }
        },
        decoration: InputDecoration(
            hintText: hint,
            labelText: lable,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(radius!),
            ),
            prefixIcon: preicon,
            suffixIcon:
                IconButton(onPressed: suffexpress, icon: Icon(posticon))));

Widget screenEmpity() => Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.add_alarm_sharp,
            size: 100,
            color: Colors.grey[300],
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            "please enter some Tasks",
            style: TextStyle(
              color: Colors.grey[300],
              fontSize: 20,
            ),
          )
        ],
      ),
    );

void navto(context, widget) =>
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
void navAndReplace(context, widget) => Navigator.pushAndRemoveUntil(
    context, MaterialPageRoute(builder: (context) => widget), (route) => false);

// Widget articalItem(artical, context) => InkWell(
//       onTap: () {
//         navto(context, Webv(artical['url']));
//       },
//       child: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: Row(
//           children: [
//             Container(
//               width: 120,
//               height: 120,
//               decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(20),
//                   image: DecorationImage(
//                     image: NetworkImage('${artical['urlToImage']}'),
//                     fit: BoxFit.cover,
//                   )),
//             ),
//             SizedBox(
//               width: 15,
//             ),
//             Expanded(
//               child: Container(
//                 height: 120,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     SizedBox(
//                       height: 15,
//                     ),
//                     Text(
//                       '${artical['title']}',
//                       maxLines: 2,
//                       overflow: TextOverflow.ellipsis,
//                       style: Theme.of(context).textTheme.bodyText1,
//                     ),
//                     SizedBox(
//                       height: 15,
//                     ),
//                     Text(
//                       '${artical['publishedAt']}',
//                       maxLines: 1,
//                       overflow: TextOverflow.ellipsis,
//                       style: TextStyle(
//                         fontWeight: FontWeight.normal,
//                         color: Colors.white,
//                         fontSize: 15,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//     );

void showToast({required msg, required state}) {
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: toastColor(state),
      textColor: Colors.white,
      fontSize: 16.0);
}

enum toastState { success, error, warning }

Color toastColor(state) {
  Color C = Colors.grey;
  switch (state) {
    case toastState.success:
      return Colors.green;

      break;
    case toastState.error:
      return Colors.red;
      break;
    case toastState.warning:
      return Colors.grey;
      break;
  }
  return C;
}
