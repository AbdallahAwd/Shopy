import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shop/modules/adel_screen/adel_screen.dart';
import 'package:shop/modules/eldawlia_screen/eldawlia.dart';
import 'package:shop/modules/hamada_screen/hamada_screen.dart';
import 'package:shop/modules/qady_screen/qady_screen.dart';
import 'package:shop/modules/sawah_screen/sawah_screen.dart';
import 'package:shop/shared/compnents/app_local.dart';
import 'package:shop/shared/compnents/component.dart';

class ReqScreen extends StatelessWidget
{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title: Text(
          '${getLang(context, 'req')}',
          style: Theme
              .of(context)
              .textTheme
              .caption
              .copyWith(fontSize: 22 , fontFamily: 'Cairo'),
        ),
        elevation: 1.0,
      ),
      body: Padding(
        padding: const EdgeInsets.only(bottom: 0 , left: 15 , right: 15 , top: 8),
        child: ListView(
          physics:const BouncingScrollPhysics(),
          children: [
            GestureDetector(
              onTap: ()
              {
                HapticFeedback.lightImpact();
                navigateTo(context, ElDawliaScreen());
              },
              child: buildStack(
                text: '${getLang(context , 'eldawlia')}',
                context: context,
                imageName:'eldawlia.jpg',
                height: 180,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 18,),
            GestureDetector(
              onTap: ()
              {
                HapticFeedback.lightImpact();
                navigateTo(context, HamadaScreen());
              },
              child: buildStack(
                text: '${getLang(context , 'hamada')}',
                context: context,
                imageName:'grocer.jpg',
                height: 180,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 18,),
            GestureDetector(
              onTap: ()
              {
                HapticFeedback.lightImpact();
                navigateTo(context, AdelScreen());
              },
              child: buildStack(
                text: '${getLang(context , '3del')}',
                context: context,
                imageName:'chicken.jpg',
                height: 180,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 18,),
            GestureDetector(
              onTap: ()
              {
                HapticFeedback.lightImpact();
                navigateTo(context, QadyScreen());
              },
              child: buildStack(
                text: '${getLang(context , 'elqady')}',
                context: context,
                imageName:'arial.jpg',
                height: 180,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 18,),
            GestureDetector(
              onTap: ()
              {
                HapticFeedback.lightImpact();
                navigateTo(context, SawahScreen());
              },
              child: buildStack(
                text: '${getLang(context , 'sawah')}',
                context: context,
                imageName:'sawah.jpg',
                height: 180,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 18,),

          ],
        ),
      ),
    );
  }
}
