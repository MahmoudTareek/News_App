// import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:news_app/cubit/cubit.dart';
import 'package:news_app/modules/details/detail_screen.dart';

Widget defaultButton({
  required VoidCallback function,
  bool isDisabled = false,
  double width = double.infinity,
  Color background = Colors.blue,
  bool isUpperCase = false,
  double radius = 0.0,
  required String text,
}) => Container(
  width: width,
  child: MaterialButton(
    onPressed: function,
    child: Text(
      isUpperCase ? text.toUpperCase() : text,
      style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 16.0,
      ),
    ),
  ),
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(radius),
    color: background,
  ),
);

Widget defaultFormField({
  required BuildContext context,
  required TextEditingController controller,
  required TextInputType type,
  bool isPassword = false,
  Function? onSubmit,
  Function? onChange,
  Function? onTap,
  required Function validate,
  String? label,
  IconData? prefix,
  IconData? suffix,
  Function? suffixPrssed,
  bool isClickable = true,
}) => TextFormField(
  controller: controller,
  keyboardType: type,
  obscureText: isPassword,
  onFieldSubmitted: (s) {
    onSubmit!(s);
  },
  onChanged: (s) {
    onChange!(s);
  },
  onTap: () {
    onTap!();
  },
  validator: (value) => validate(value),
  enabled: isClickable,
  decoration: InputDecoration(
    labelStyle: TextStyle(color: Colors.black),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.blue),
    ),
    labelText: label,
    prefixIcon: prefix != null ? Icon(prefix) : null,
    suffix: suffix != null
        ? IconButton(
            onPressed: () {
              isPassword = !isPassword;
              suffixPrssed!();
            },
            icon: Icon(suffix),
          )
        : null,
    border: OutlineInputBorder(),
  ),
);

Widget myDivider() => Padding(
  padding: const EdgeInsetsDirectional.only(start: 20.0),
  child: Container(
    width: double.infinity,
    height: 2.0,
    color: Colors.grey[300],
  ),
);

Future<dynamic> navigateTo(context, widget) =>
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));

Widget buildArticleItem(article, context) => InkWell(
  onTap: () {
    var hours = hour(articleTime: article['publishedAt']);
    navigateTo(
      context,
      DetailScreen(
        articleImageURL:
            article['urlToImage'] ?? 'https://via.placeholder.com/150',
        articleTitle: article['title'] ?? 'No Title',
        articleContent: article['content'] ?? 'No Content',
        articleSource: article['source']['name'] ?? 'Unknown Source',
        articlePublishedTime: hours.toString(),
        articleURL: article['url'] ?? '',
      ),
    );
  },
  child: Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children: [
        Container(
          width: 120.0,
          height: 120.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            image: DecorationImage(
              image: NetworkImage('${article['urlToImage']}'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(width: 10.0),
        Expanded(
          child: Container(
            height: 120.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  '${article['category'] ?? 'General'}',
                  style: TextStyle(color: Colors.grey),
                ),
                SizedBox(height: 10.0),
                Expanded(
                  child: Text(
                    '${article['title']}',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 8.0,
                      backgroundImage: Image(
                        image: AssetImage('assets/images/profile.jpg'),
                      ).image,
                    ),
                    SizedBox(width: 2.0),
                    Expanded(
                      child: Text(
                        '${article['source']['name']}',
                        style: TextStyle(
                          color: Colors.black45,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Icon(
                      Icons.access_time_rounded,
                      size: 14.0,
                      color: Colors.black54,
                    ),
                    SizedBox(width: 3.0),
                    Text(
                      '${hour(articleTime: article['publishedAt'])}h ago',
                      style: TextStyle(color: Colors.black54),
                    ),
                    Spacer(),
                    Icon(Icons.more_horiz, size: 20.0, color: Colors.grey),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  ),
);

Widget articleBuilder(list, context, {isSearch = false}) => ConditionalBuilder(
  condition: list.length > 0,
  builder: (context) => ListView.separated(
    physics: BouncingScrollPhysics(),
    shrinkWrap: true,
    itemBuilder: (context, index) => buildArticleItem(list[index], context),
    separatorBuilder: (context, index) => SizedBox(height: 1.0),
    itemCount: list.length,
  ),
  fallback: (context) =>
      isSearch ? Container() : Center(child: CircularProgressIndicator()),
);

int hour({required articleTime}) {
  String publishedAt = articleTime;
  DateTime publishedTime = DateTime.parse(publishedAt);
  Duration diff = DateTime.now().difference(publishedTime);
  int hoursAgo = diff.inHours;
  return hoursAgo;
}
