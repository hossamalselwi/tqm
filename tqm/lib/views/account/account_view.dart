import 'dart:io';
import 'dart:math';

import 'package:bot_toast/bot_toast.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb;
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:tqm/managers/user_manager.dart';
import 'package:tqm/models/user.dart';
import 'package:tqm/utils/local_storage.dart';
import 'package:tqm/utils/ui_utils/custom_colors.dart';
import 'package:tqm/views/account/personal_account_view.dart';
import 'package:textfield_tags/textfield_tags.dart';

final UserManager _userManager = UserManager();
final LocalStorage _localStorage = LocalStorage();

class AccountView extends StatefulWidget {
  @override
  _AccountViewState createState() => _AccountViewState();
}

class _AccountViewState extends State<AccountView> {
  String nameOrgAccount;

  getName() async {
    var nameAccount1 = await _localStorage.getName();
    setState(() {
      nameOrgAccount = nameAccount1.toString();
    });
  }

  @override
  void initState() {
    super.initState();
    getName();
  }

  List<String> teams = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'الحساب',
          style: Theme.of(context)
              .textTheme
              .headline6
              .copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(24),
        children: [
          StreamBuilder<User>(
              stream: _userManager.getUserInformation().asStream(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Column(
                    children: [
                      Center(
                        child: CircleAvatar(
                          backgroundColor: Colors.primaries[
                                  Random().nextInt(Colors.primaries.length)]
                              .withOpacity(.2),
                          radius: 60,
                          backgroundImage: ExactAssetImage('assets/avatar.png'),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Center(
                          child: Text(
                        'المدير العام ',
                        style: Theme.of(context)
                            .textTheme
                            .headline6
                            .copyWith(fontWeight: FontWeight.w600),
                      )),
                      SizedBox(
                        height: 10,
                      ),
                      Center(
                          child: Text(
                        'عرض بروفايلي',
                        style: Theme.of(context).textTheme.bodyText2.copyWith(
                            fontWeight: FontWeight.normal,
                            color: customRedColor),
                      )),
                      SizedBox(
                        height: 25,
                      ),
                      Text(
                        'المنشأة',
                        style: Theme.of(context).textTheme.bodyText1.copyWith(
                            fontWeight: FontWeight.normal,
                            color: customGreyColor),
                      ),
                      Material(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: ListTile(
                          title: Text(
                            nameOrgAccount,
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                          subtitle: Text(
                            'info@mail.com',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2
                                .copyWith(color: customGreyColor),
                          ),
                          trailing: TextButton(
                              style: TextButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30)),
                                backgroundColor: customRedColor,
                              ),
                              onPressed: () {
                                Navigator.of(context)
                                    .pushNamed('/organizationView')
                                    .then((value) => getName());
                              },
                              child: Text(
                                'عرض',
                                style: Theme.of(context)
                                    .textTheme
                                    .button
                                    .copyWith(color: Colors.white),
                              )),
                        ),
                      ),
                    ],
                  );
                }
                return Column(
                  children: [
                    Center(
                      child: CircleAvatar(
                        backgroundColor: Colors.primaries[
                                Random().nextInt(Colors.primaries.length)]
                            .withOpacity(.2),
                        radius: 60,
                        backgroundImage: snapshot.data == null
                            ? ExactAssetImage('assets/avatar.png')
                            : NetworkImage(snapshot.data.data.picture),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Center(
                        child: Text(
                      '${snapshot.data.data.name}',
                      style: Theme.of(context)
                          .textTheme
                          .headline6
                          .copyWith(fontWeight: FontWeight.w600),
                    )),
                    SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: InkWell(
                        onTap: () {
                          if (Platform.isIOS) {
                            showCupertinoModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return PersonalAccountView();
                              },
                            );
                          } else {
                            showMaterialModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return PersonalAccountView();
                              },
                            );
                          }
                        },
                        child: Text(
                          'عرض بروفايلي ',
                          style: Theme.of(context).textTheme.bodyText2.copyWith(
                              fontWeight: FontWeight.normal,
                              color: customRedColor),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Text(
                      'المنشاة ',
                      style: Theme.of(context).textTheme.bodyText1.copyWith(
                          fontWeight: FontWeight.normal,
                          color: customGreyColor),
                    ),
                    Material(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: ListTile(
                        title: Text(
                          '${snapshot.data?.data?.organization?.name}',
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                        subtitle: Text(
                          '${snapshot.data?.data?.email}',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2
                              .copyWith(color: customGreyColor),
                        ),
                        trailing: TextButton(
                            style: TextButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30)),
                              backgroundColor: customRedColor,
                            ),
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      content: SizedBox(
                                        height: 150,
                                        child: Column(
                                          children: [
                                            TextFieldTags(
                                              textFieldStyler: TextFieldStyler(
                                                helperText: '',
                                                cursorColor: Theme.of(context)
                                                    .textSelectionTheme
                                                    .cursorColor,
                                                hintStyle: Theme.of(context)
                                                    .textTheme
                                                    .bodyText1
                                                    .copyWith(
                                                        color: Colors.grey),
                                                hintText: 'Emails',
                                                textFieldBorder:
                                                    UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color:
                                                                customGreyColor)),
                                                textStyle: Theme.of(context)
                                                    .textTheme
                                                    .bodyText1,
                                                textFieldEnabledBorder:
                                                    UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color:
                                                                customGreyColor)),
                                                textFieldFocusedBorder:
                                                    UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color:
                                                                customGreyColor)),
                                              ),
                                              //[tagsStyler] is required and shall not be null
                                              tagsStyler: TagsStyler(
                                                //These are properties you can tweek for customization of tags
                                                tagTextStyle: Theme.of(context)
                                                    .textTheme
                                                    .bodyText1
                                                    .copyWith(
                                                        color: Colors.white),
                                                tagDecoration: BoxDecoration(
                                                  color: customRedColor,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0),
                                                ),
                                                tagCancelIcon: Icon(
                                                    Icons.cancel,
                                                    size: 18.0,
                                                    color: Colors.white),
                                                tagPadding:
                                                    const EdgeInsets.all(8.0),

                                                // EdgeInsets tagPadding = const EdgeInsets.all(4.0),
                                                // EdgeInsets tagMargin = const EdgeInsets.symmetric(horizontal: 4.0),
                                                // BoxDecoration tagDecoration = const BoxDecoration(color: Color.fromARGB(255, 74, 137, 92)),
                                                // TextStyle tagTextStyle,
                                                // Icon tagCancelIcon = const Icon(Icons.cancel, size: 18.0, color: Colors.green)
                                                // isHashTag: true,
                                              ),
                                              onTag: (tag) {
                                                //This give you tags entered
                                                print('onTag ' + tag);
                                                setState(() {
                                                  teams.add(tag);
                                                });
                                              },
                                              onDelete: (tag) {
                                                print('onDelete ' + tag);
                                                setState(() {
                                                  teams.remove(tag);
                                                });
                                              },
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            TextButton(
                                                style: TextButton.styleFrom(
                                                    backgroundColor:
                                                        customRedColor,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                    )),
                                                onPressed: () {},
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 15, right: 15),
                                                  child: Text(
                                                    'Invite email(s)',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .button
                                                        .copyWith(
                                                            color:
                                                                Colors.white),
                                                  ),
                                                ))
                                          ],
                                        ),
                                      ),
                                    );
                                  });
                            },
                            child: Text(
                              'عرض',
                              style: Theme.of(context)
                                  .textTheme
                                  .button
                                  .copyWith(color: Colors.white),
                            )),
                      ),
                    ),
                  ],
                );
              }),
          SizedBox(
            height: 25,
          ),
          Text(
            'الاشعارات',
            style: Theme.of(context).textTheme.bodyText1.copyWith(
                fontWeight: FontWeight.normal, color: customGreyColor),
          ),
          Material(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Column(
              children: [
                /*ListTile(
                  title: Text(
                    'Do not disturb',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  subtitle: Text(
                    'Off',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        .copyWith(color: customGreyColor),
                  ),
                  leading: Icon(Icons.notifications_paused_outlined,
                      color: Theme.of(context).iconTheme.color, size: 30),
                  trailing: IconButton(
                      onPressed: () {},
                      icon: Icon(
                          Platform.isIOS
                              ? Icons.arrow_forward_ios_sharp
                              : Icons.arrow_forward,
                          color: Theme.of(context).iconTheme.color)),
                ),*/
                Divider(),
                ListTile(
                  title: Text(
                    'معلومات الترخيص',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  subtitle: Text(
                    'ادارة',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        .copyWith(color: customGreyColor),
                  ),
                  leading: Icon(
                    Entypo.notification,
                    color: Theme.of(context).iconTheme.color,
                    size: 30,
                  ),
                  trailing: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.arrow_forward_ios_sharp,
                        color: Theme.of(context).iconTheme.color,
                      )),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 25,
          ),
          Text(
            'الدعم',
            style: Theme.of(context).textTheme.bodyText1.copyWith(
                fontWeight: FontWeight.normal, color: customGreyColor),
          ),
          Material(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Column(
              children: [
                ListTile(
                  title: Text(
                    'iOS guide',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  leading: Icon(Icons.info_outline_rounded,
                      color: Theme.of(context).iconTheme.color, size: 30),
                  trailing: IconButton(
                      onPressed: () {},
                      icon: Icon(
                          Platform.isIOS
                              ? Icons.arrow_forward_ios_sharp
                              : Icons.arrow_forward,
                          color: Theme.of(context).iconTheme.color)),
                ),
                Divider(),
                ListTile(
                  title: Text(
                    'تواصل مع الدعم',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  leading: Icon(
                    Icons.chat_bubble_outline_rounded,
                    color: Theme.of(context).iconTheme.color,
                    size: 30,
                  ),
                  trailing: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.arrow_forward_ios_sharp,
                        color: Theme.of(context).iconTheme.color,
                      )),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 25,
          ),
          Text(
            'اكثر',
            style: Theme.of(context).textTheme.bodyText1.copyWith(
                fontWeight: FontWeight.normal, color: customGreyColor),
          ),
          Material(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Column(
              children: [
                ListTile(
                  title: Text(
                    'تقييم التطبيق',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  leading: Icon(Icons.star_border_rounded,
                      color: Theme.of(context).iconTheme.color, size: 30),
                  trailing: IconButton(
                      onPressed: () {},
                      icon: Icon(
                          Platform.isIOS
                              ? Icons.arrow_forward_ios_sharp
                              : Icons.arrow_forward,
                          color: Theme.of(context).iconTheme.color)),
                ),
                Divider(),
                ListTile(
                  title: Text(
                    'سياسة الخصوصية',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  leading: Icon(
                    Icons.visibility_outlined,
                    color: Theme.of(context).iconTheme.color,
                    size: 30,
                  ),
                  trailing: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.arrow_forward_ios_sharp,
                        color: Theme.of(context).iconTheme.color,
                      )),
                ),
                Divider(),
                ListTile(
                  title: Text(
                    'من نحن',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  leading: Icon(
                    Feather.settings,
                    color: Theme.of(context).iconTheme.color,
                    size: 30,
                  ),
                  trailing: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.arrow_forward_ios_sharp,
                        color: Theme.of(context).iconTheme.color,
                      )),
                ),
                Divider(),
                ListTile(
                  title: Text(
                    'حول التطبيق',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  leading: Icon(
                    Platform.isIOS
                        ? Ionicons.ios_phone_portrait
                        : Ionicons.md_phone_portrait,
                    color: Theme.of(context).iconTheme.color,
                    size: 30,
                  ),
                  trailing: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.arrow_forward_ios_sharp,
                        color: Theme.of(context).iconTheme.color,
                      )),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 30,
          ),
          TextButton(
              style: TextButton.styleFrom(
                padding: EdgeInsets.all(10),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                backgroundColor: Theme.of(context).cardColor,
              ),
              onPressed: () async {
                BotToast.showLoading(
                    allowClick: false,
                    clickClose: false,
                    backButtonBehavior: BackButtonBehavior.ignore);
                final fb.FirebaseAuth firebaseAuth = fb.FirebaseAuth.instance;
                firebaseAuth.signOut().then((_) async {
                  await _localStorage.clearStorage();
                  BotToast.closeAllLoading();
                  Navigator.pushNamedAndRemoveUntil(
                      context, '/loginView', (route) => false);
                });
              },
              child: Text(
                'تسجيل الخروج ',
                style: Theme.of(context)
                    .textTheme
                    .button
                    .copyWith(color: customRedColor),
              ))
        ],
      ),
    );
  }
}

//////////
/////////////
////////////
//////////////
//////////////
///
///
///
