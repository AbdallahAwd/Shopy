import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:shop/shared/Cubit/Home/home_cubit.dart';

Widget defaultTextFormFeild({
  @required TextEditingController controller,
  @required IconData pre,
  @required String HintText,
  Function validate,
  var onChange,
  IconData suff,
  var suffixWidget,
  bool isObscure = false,
  @required var KeyType,
  Function suffPress,
  Function onTab,
  var submit,
  var context,
}) =>
    TextFormField(
      keyboardType: KeyType,
      style: Theme.of(context).textTheme.bodyText1.copyWith(fontFamily: 'Cairo'),
      obscureText: isObscure,
      controller: controller,
      onChanged: onChange,
      maxLines: 1,
      onTap: onTab,
      onFieldSubmitted: submit,
      cursorColor: Colors.white,
      decoration: InputDecoration(
        labelStyle: Theme.of(context).textTheme.bodyText1.copyWith(fontFamily: 'Cairo'),
        hintStyle: Theme.of(context).textTheme.bodyText1.copyWith(fontFamily: 'Cairo'),
        prefixIcon: Icon(pre , color: HomeCubit.get(context).isDark ? Colors.white : Colors.black12,),
        suffix: suffixWidget,
        suffixIcon: IconButton(onPressed: suffPress, icon: Icon(suff)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        labelText: HintText,
      ),
      validator: validate,
    );

defaultButton({
  @required onPress,
  @required String text,
  double fontSize = 18,
  Color defaultFontColor = Colors.white,
  dynamic width = double.infinity,
}) =>
    Container(
      width: width,
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: MaterialButton(
        onPressed: onPress,
        color: HexColor('#142B52'),
        child: Text(
          text.toUpperCase(),
          style: TextStyle(
              color: defaultFontColor,
              fontWeight: FontWeight.w700,
              fontSize: fontSize),
        ),
      ),
    );

snackBar(context, {@required text, color = Colors.green}) {
  var snackBar = SnackBar(
    content: Text(text),
    backgroundColor: color,
    duration: Duration(milliseconds: 500),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

navigateTo(context, screen) {
  return Navigator.push(
      context, MaterialPageRoute(builder: (context) => screen));
}

navigateAnd(context, screen) {
  return Navigator.pushAndRemoveUntil(context,
      MaterialPageRoute(builder: (context) => screen), (route) => false);
}

Widget buildStack({@required context, @required text, @required imageName , double height = 200.0 , fit = null}) {
  return Stack(
    alignment: AlignmentDirectional.center,
    children: [
      Container(
        width: double.infinity,
        height: height,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(45),
          image: DecorationImage(
            image: AssetImage('assets/$imageName'),
            fit: fit,
          ),
        ),
      ),
      Container(
        width: double.infinity,
        height: height,
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.5),
          borderRadius: BorderRadius.circular(45),
        ),
      ),
      Text(
        text,
        style: Theme.of(context)
            .textTheme
            .bodyText1
            .copyWith(fontSize: 35, color: Colors.white , fontFamily: 'Cairo'),
      )
    ],
  );
}

Widget ListTileBuilder({
  @required context,
  @required IconWidget,
  @required text,
  @required onTab,
  double fontSize,
}) =>
    Column(
      children: [
        ListTile(
          leading: IconWidget,
          onTap: onTab,
          title: Text(
            '$text',
            style: Theme.of(context)
                .textTheme
                .bodyText1
                .copyWith(fontSize: fontSize , fontFamily: 'Cairo'),
          ),
        ),
        const Divider(
          height: 1,
          color: Colors.grey,
        ),
      ],
    );

String Now = DateFormat.yMMMd().format(DateTime.now());
String formattedTime = DateFormat.Hm().format(DateTime.now());


