import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:sscconnect/components/components.dart';
import 'package:sscconnect/utils/utils.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  AccountScreenState createState() => AccountScreenState();
}

class AccountScreenState extends State<AccountScreen> {
  Widget userInfo() {
    return Padding(
      padding: EdgeInsets.all(
        adaptiveWidthSize(context, 20),
      ),
      child: CCard(
        child: GestureDetector(
          onTap: () {
            // context.navigate((context) => ProfileEditScreen());
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Andrew Russel Garfield",
                      style: TextStyle(
                        fontSize: adaptiveWidthSize(context, 30),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      "andrew@sspconnect.co.id",
                      style: TextStyle(
                        fontSize: adaptiveWidthSize(context, 25),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  right: adaptiveWidthSize(context, 5),
                ),
                child: Icon(
                  Feather.edit,
                  color: primaryColor,
                  size: adaptiveWidthSize(context, 40),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget menuListItem(String title, IconData icon, Widget? routeName) {
    return InkWell(
      splashColor: Color(0x11000000),
      onTap: () {
        if (routeName != null) {
          context.navigate((context) => routeName);
        }
      },
      child: Container(
        margin: EdgeInsets.symmetric(
          vertical: adaptiveWidthSize(context, 20),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: adaptiveWidthSize(context, 35),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  margin: EdgeInsets.only(
                    right: adaptiveWidthSize(context, 10),
                  ),
                  padding: EdgeInsets.all(
                    adaptiveWidthSize(context, 20),
                  ),
                  decoration: BoxDecoration(
                    color: Color(0x11000000),
                    borderRadius: BorderRadius.circular(
                      adaptiveWidthSize(context, 50),
                    ),
                  ),
                  child: Icon(
                    icon,
                    size: adaptiveWidthSize(context, 35),
                    color: Color(0xff515672),
                  ),
                ),
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: adaptiveWidthSize(context, 30),
                  ),
                ),
              ],
            ),
            Icon(
              Feather.chevron_right,
              size: adaptiveWidthSize(context, 35),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CAppBar(
        title: "My Profile",
      ),
      body: ListView(
        physics: ClampingScrollPhysics(),
        children: [
          userInfo(),
          Padding(
            padding: EdgeInsets.only(
              top: adaptiveWidthSize(context, 15),
            ),
            child: menuListItem(
              "Help & Support",
              Icons.contact_support_outlined,
              null,
            ),
          ),
          menuListItem(
            "Privacy Policy",
            Icons.policy_outlined,
            null,
          ),
          CSeparator(),
          menuListItem(
            "Settings",
            Icons.settings_outlined,
            null,
          ),
          Container(
            margin: EdgeInsets.symmetric(
              vertical: adaptiveWidthSize(context, 25),
            ),
            child: GestureDetector(
              onTap: () {
                context.pushPermanent("sign-in");
              },
              child: Center(
                child: Container(
                  padding: EdgeInsets.symmetric(
                    vertical: adaptiveWidthSize(context, 15),
                    horizontal: adaptiveWidthSize(context, 75),
                  ),
                  decoration: BoxDecoration(
                    color: Colors.redAccent.withAlpha(0x22),
                    border: Border.all(color: Colors.redAccent),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Text(
                    "Sign Out",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.red,
                      fontSize: adaptiveWidthSize(context, 30),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
