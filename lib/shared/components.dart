import 'package:flutter/material.dart';

Color maincolor = const Color(0xff3e536e);
Color favoritesColor = Colors.red;
Color detailsBackground = const Color(0xfff4f3f6);

Widget defaultButton({
  double width = double.infinity,
  Color background = Colors.blue,
  double raduis = 10.0,
  double height = 40.0,
  bool isUpperCase = true,
  required function,
  required String text,
}) => Container(
  width: width,
  height: height,
  // ignore: sort_child_properties_last
  child: MaterialButton(
    onPressed: function,
    child: Text(
      isUpperCase ? text.toUpperCase() : text,
      style: const TextStyle(color: Colors.white),
    ),
  ),
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(raduis),
    color: background,
  ),
);

Widget defaultTextButton({
  required VoidCallback function,
  required String text,
}) => TextButton(
  onPressed: function,
  child: Text(
    text.toUpperCase(),
    style: const TextStyle(fontWeight: FontWeight.bold),
  ),
);

Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
  onSubmit,
  onTab,
  onChange,
  bool isPassword = false,
  required validate,
  required String label,
  required IconData prefix,
  IconData? suffix,
  suffixPressed,
  bool isClickable = true,
}) => TextFormField(
  controller: controller,
  keyboardType: type,
  obscureText: isPassword,
  enabled: isClickable,
  onFieldSubmitted: onSubmit,
  onTap: onTab,
  onChanged: onChange,
  validator: validate,
  decoration: InputDecoration(
    labelText: label,
    prefixIcon: Icon(prefix),
    suffixIcon: suffix != null
        ? IconButton(onPressed: suffixPressed, icon: Icon(suffix))
        : null,
    border: const OutlineInputBorder(),
  ),
);

void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
  context,
  MaterialPageRoute(builder: (context) => widget),
  (route) => false,
);

Widget myDivider() => Padding(
  padding: const EdgeInsetsDirectional.only(start: 20.0),
  child: Container(
    width: double.infinity,
    height: 1.0,
    color: Colors.grey[300],
  ),
);
