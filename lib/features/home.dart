import 'package:inventory/core/constants.dart';
import 'package:flutter/material.dart';
import 'package:inventory/core/screen_utils/screen_utils.dart';
import 'package:inventory/core/ui/styles/global_colors.dart';
import 'package:inventory/core/validators/base_validator.dart';
import 'package:inventory/core/validators/required_validator.dart';
import 'package:inventory/shared/components/components.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:url_launcher/url_launcher.dart';
import 'navigationDrawer/navigationDrawer.dart';
import 'package:sizer/sizer.dart';

class HomeWidget extends StatefulWidget {
  static const routeName = 'HomeWidget';

  HomeWidget({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}
class _MyHomePageState extends State<HomeWidget> {
  final _key = new GlobalKey<FormFieldState<String>>();
  final shipmentNoController = TextEditingController();
  int index = 0;

  @override
  Widget  build(BuildContext context) {
    return Scaffold(
      appBar: defaultAppBar(
        context: context,
        title: 'Create',),

      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  alignment: AlignmentDirectional.topEnd,
                  children: [
                    Container(
                      height: 160.0,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4.0,),
                        image: DecorationImage(
                          image:NetworkImage(
                            'https://image.freepik.com/free-photo/skeptical-woman-has-unsure-questioned-expression-points-fingers-sideways_273609-40770.jpg',
                          ),
                          // image: FileImage(SocialCubit.get(context).postImage),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: CircleAvatar(
                        radius: 20.0,
                        child: Icon(
                          Icons.close,
                          size: 16.0,
                        ),
                      ),
                      onPressed: ()
                      {
                        // SocialCubit.get(context).removePostImage();
                      },
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.0,
                ),
                Row(
                    children: [
                Expanded(
                child: TextButton(
                onPressed: () {
                  // SocialCubit.get(context).getPostImage();
               },
                  child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                            Icons.photo_library ,
                          ),
                SizedBox(
                            width: 5.0,
                          ),
                Text(
                            'add photo',
                          ),
              ],
            ),
                ),
                ),
                      Expanded(
                        child: TextButton(
                          onPressed: () {},
                          child:Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.settings_overscan ,
                              ),
                              SizedBox(
                                width: 5.0,
                              ),
                              Text(
                                'Scan',
                              ),
                            ],
                          ),
                        ),
                      ),
                    ]
                ),
                SizedBox(
                  height: 20.0,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(228, 237, 240, 1),
                         borderRadius: BorderRadius.circular(ScreensHelper.fromWidth(1.5)),
                          border: Border.all(width: 1,color: GlobalColors.primaryGreen)
                        ),

                        height: 45,
                        child: Center(child: Text('12228888888882854 ,555hhhhhhhhh555 ,8888888')),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 20.0,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        child: defaultFormField(
                          controller: shipmentNoController,
                          formKey: _key,
                          label: 'ShipmentNo',
                          type: TextInputType.text,
                          isPassword: true,
                          prefix: Icons.widgets ,
                          validate: (value) {
                            return BaseValidator.validateValue(
                              context,
                              value,
                              [
                                RequiredValidator(),
                              ],
                              true,
                            );
                          },
                        ),
                      ),
                    )
                  ],
                ),
                Container(
                    child: ListView.builder(
                      physics: BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: 6,
                      itemBuilder: (context, i) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              index = i;
                            });
                          },
                          child: ListTile(
                            leading: index == i
                                ? Icon(Icons.check_box,color: GlobalColors.darkGreen,)
                                : Icon(Icons.check_box_outline_blank),
                            title: Text('one Two ${i}',),
                          ),
                        );
                      },
                    ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                createBtn(context)
              ],
            ) ,
          ),
        ),
      ),
    );
  }

  Widget createBtn(context) {
    return Center(
        child: Container(
            width: 80.w,
            height: 45,
            child: ElevatedButton(

              child: new Text('Send',),
              onPressed: () {
                //
              },
            )));
  }
}