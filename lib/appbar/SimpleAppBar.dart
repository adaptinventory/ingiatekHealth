import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:touchpointhealth/Utils/AppImages.dart';
import 'package:touchpointhealth/appstate/AppState.dart';
import 'package:touchpointhealth/menu/screen/MenuScreen.dart';


class SimpleAppbar extends StatefulWidget implements PreferredSizeWidget{
  String? backTitle;
  double height;
  double width;
  double elevation;
  PreferredSizeWidget? bottom;
  String? backIcon;
  List<Widget>? actions;
  SimpleAppbar({super.key, this.backTitle,this.backIcon,this.width = 50,this.height = kToolbarHeight,this.bottom, this.elevation = 1,this.actions});

  @override
  State<SimpleAppbar> createState() => _SimpleAppbarState();

  @override
  Size get preferredSize => Size.fromHeight(height);
}

class _SimpleAppbarState extends State<SimpleAppbar> {

  String? patientName;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    patientName = AppState().patient?.displayName ?? '';
  }

  double toolBarHeight(){
    if(showNotification){
      return 120;
    }
    return widget.height;
  }

  bool showNotification = false;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leadingWidth: widget.width,
      toolbarHeight: toolBarHeight(),
      elevation: widget.elevation,
      leading: IconButton(
        icon: widget.backIcon != null ? SvgPicture.asset(widget.backIcon ?? '',width: 50,height: 30,) : SvgPicture.asset(AppImages.hamburgerIcon),
        padding: const EdgeInsets.only(top: 5,right: 15),
        tooltip: 'Menu Icon',
        onPressed: () {
          if(widget.backIcon != null){
            Navigator.pop(context);
          }else {
            Navigator.push(context,
              MaterialPageRoute(
                builder: (context) => MenuScreen(),
              ),
            );
          }
        },
      ),
      actions: [
      IconButton(
        icon: /*SvgPicture.asset(AppImages.dotIcon)*/ Text(patientName ?? ''),
        padding: const EdgeInsets.only(top: 5,right: 20),
        onPressed: () {},
      ),
      ],
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
    );
  }
}




