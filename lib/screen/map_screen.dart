import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mapp/constant/text_style.dart';
import 'package:mapp/gen/assets.gen.dart';

import '../constant/dimens.dart';
import '../widget/back_button.dart';

class currentWidgetState{
  currentWidgetState._();
  static const stateSelectOrigin = 0;
  static const stateSelectDestination = 1;
  static const stateRequestDriver = 2;
}

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
   
   List<GeoPoint>geoPoint = [];
   Widget markerIcon = SvgPicture.asset(Assets.icons.origin,height: 100,width: 40,);
   
   MapController mapController = MapController(
    //این اونجایی که مکانی که من حضور دارم مقدار دهی شود 
    initMapWithUserPosition: false,
    //طول و عرض جغرافیایی
    //که میتوانیم مپ را با استفاده از این طول و عرض جغرافیایی اینیت کنیمinit
    initPosition: GeoPoint(latitude:35.7367516373 ,longitude: 51.2911096718),
   );

    List currentWidgetList = [currentWidgetState.stateSelectOrigin];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
      body: Stack(
        children: [
          //osmMap
         SizedBox.expand(
          child: OSMFlutter(
            controller: mapController,
             trackMyPosition: false,
             //مقدار زوم اولیه را میده
             initZoom: 15,
             //مارکر مبدا که با استفاده از مارکر که فعال باشد ما بتوانیم مبدا را پیدا کنیم
             isPicker:true,
             //تا زمانی که در حالت لودینگ هست این ویجت را نمایش دهد
             mapIsLoading: const SpinKitCircle(color: Colors.black),
             //تا کجا میتواند زوم را ببندیم و باز کنیم 
             minZoomLevel: 8,
             maxZoomLevel: 18,
             //چندتا زوم بشه ما اینجا یک واحد یک واحد 
             stepZoom: 1,


             //زمانی که جیوپوینت کلیک میشود یک چیزی اجرا شود که بستگی به پروژه دارد
            // onGeoPointClicked: ,
             
           // یا زمانی که لوکیشن کاربر تغییر میکند یک کاری را انجام بده
           //مثال قرار که هربار لوکیشن تغییر کرد مثلا ببیند که ماشین روی نقشه کجاست ماشین
           //یا موتور هست که یک موتور نمایش داده میشود در نقشه
           // onLocationChanged: ,

           
           //در واقع زمانی که مپ اماده باشد چه کدی را بزاریم 
            //میخوایم به عنوان مشتری اون اتومبیل هایی که اطراف هستند را روی نقشه ببینیم  که یک حلقه بزاریم و از سرور دریافت کنیم 
           //onMapIsReady: ,
           
            
            //این هم مارکر هست 
           //userLocationMarker: UserLocationMaker(personMarker: MarkerIcon()),


          ),
         ),

          //currentWidget
          currentWidget(),

             MyBackButton(onPressed: () { 
                if(currentWidgetList.length>1){
                  setState(() {
                    //یعنی اخریش را حذف کن از اخر
                     currentWidgetList.removeLast();
                  });
                 
                }
              },),
        ],
      ),
    )); 
  }
      
      //اینجا میگیم اگر اخرین index هرجی بود بهمون برگردونه همونو
      Widget currentWidget(){
        Widget widget = origin();
        //اخرین indexکه دارد 
        switch(currentWidgetList.last){
           case currentWidgetState.stateSelectOrigin:
           widget = origin();
           break;
           case currentWidgetState.stateSelectDestination:
           widget = dest();
           break;
           case currentWidgetState.stateRequestDriver:
           widget = reqDriver();
           break;
        
        }
        return widget;

      }

  Positioned origin() {
    return Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Padding(
            padding: const EdgeInsets.all(Dimens.lorge),
            child: ElevatedButton(onPressed: () {
                setState(() {
                  currentWidgetList.add(currentWidgetState.stateSelectDestination);
                });
            }, child: Text("انتخاب مبدا",style: MyTextStyle.bottom,)),
          ),
        );
  }  
  Positioned dest() {
    return Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Padding(
            padding: const EdgeInsets.all(Dimens.lorge),
            child: ElevatedButton(onPressed: () {
              setState(() {
                currentWidgetList.add(currentWidgetState.stateRequestDriver);
              });
            }, child: Text("انتخاب مقصد",style: MyTextStyle.bottom,)),
          ),
        );
  }  
  Positioned reqDriver() {
    return Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Padding(
            padding: const EdgeInsets.all(Dimens.lorge),
            child: ElevatedButton(onPressed: () {
              
            }, child: Text("درخواست راننده",style: MyTextStyle.bottom,)),
          ),
        );
  }
}

