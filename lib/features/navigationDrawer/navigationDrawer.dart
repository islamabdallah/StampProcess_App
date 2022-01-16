import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory/core/constants.dart';
import 'package:flutter/material.dart';
import 'package:inventory/features/login/data/models/user-model.dart';
import 'package:inventory/features/login/presentation/pages/loginScreen.dart';
import 'package:inventory/features/trip/presentation/bloc/trip_cubit.dart';
import 'package:inventory/features/trip/presentation/pages/tripScreen.dart';
import 'package:inventory/shared/components/components.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

import '../home.dart';

class NavigationDrawer extends StatefulWidget {

 NavigationDrawerState createState() => NavigationDrawerState();
}

class NavigationDrawerState extends State<NavigationDrawer> {


  @override
 void initState() {
   // TODO: implement initState
   super.initState();
 }



 @override
 Widget  build(BuildContext context) {
   // TODO: implement  build
   return  BlocConsumer<TripCubit, TripState>(
     builder: (context, state) {
       TripCubit cubit = TripCubit.get(context);
       return  Drawer(
         child: ListView(
           padding: EdgeInsets.zero,
           children: <Widget>[
             UserAccountsDrawerHeader(
               accountName: Text(cubit.user.userName ?? ''),
               accountEmail: Text(cubit.user.name ?? ''),
               currentAccountPicture: CircleAvatar(
                 backgroundColor: Colors.orange,
                 child: Text(
                   cubit.user.name?.substring(0,1).toUpperCase() ??
                   'A',
                   style: TextStyle(fontSize: 40.0),
                 ),
               ),

             ),

             // ListTile(
             //   leading: Icon(Icons.person,),
             //   title: Text('myAccount'.tr(),
             //       style: TextStyle(fontFamily: FONT_FAMILY, fontWeight: FontWeight.w400,)),
             //   onTap: () {
             //
             //   },
             // ),
             ListTile(
               leading: Icon(Icons.home,),
               title: Text('homeTitle'.tr(),
                   style: TextStyle(fontFamily: FONT_FAMILY, fontWeight: FontWeight.w400,)),
               onTap: () {
                 Navigator.pop(context);
                 navigateTo(context, TripWidget());
               },
             ),
             ListTile(
               leading: Icon(Icons.language,),
               title: PopupMenuButton<String>(
                 child: Text('language'.tr(),style: TextStyle(fontFamily: FONT_FAMILY, fontWeight: FontWeight.w400,)),
                 onSelected: (lang) => cubit.choiceLanguage(lang, context),
                 initialValue: cubit.currentLanguage,
                 itemBuilder: (BuildContext context) {
                   return cubit.languages.map((Map<String, String> lang) {
                     return PopupMenuItem<String>(
                       value: lang['value'],
                       child: Text('${lang['name']}'.tr() ,
                           style: TextStyle(fontFamily: FONT_FAMILY, fontWeight: FontWeight.w400,)),
                     );
                   }).toList();
                 },),
               onTap: () {
                 //     Navigator.pop(context);
               },
             ),
             Divider(),
             ListTile(
               leading:   Icon(Icons.logout,color: Colors.red,),
               title: Text('logout'.tr(),
                   style: TextStyle(fontFamily: FONT_FAMILY, fontWeight: FontWeight.w400,)),
               onTap: cubit.logOut,
               //     () {
               //   Navigator.pop(context);
               //
               // }

             ),
           ],
         ),
       );
     } ,
     listener:  (context, state) {
       if (state is UserLogOutSuccessState) navigateAndFinish(context,LoginScreen());
     },
   );
 }

}