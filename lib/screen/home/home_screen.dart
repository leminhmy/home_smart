import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:youtobe_demo/repositories/home_room_repo.dart';
import 'package:youtobe_demo/repositories/member_repo.dart';
import 'package:youtobe_demo/repositories/weather_repo.dart';
import 'package:youtobe_demo/screen/details/detail_screen.dart';
import 'package:youtobe_demo/screen/home/bloc/home_bloc.dart';
import 'package:youtobe_demo/screen/widget/small_text.dart';

import '../../services/boredService.dart';
import '../../services/connectivityService.dart';
import '../map/current_location.dart';
import '../widget/animated_toggle.dart';
import '../widget/big_text.dart';
import '../widget/swich_and_text.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin{

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc(
        RepositoryProvider.of<BoredService>(context),
        RepositoryProvider.of<ConnectivityService>(context),
        RepositoryProvider.of<HomeRoomRepo>(context),
        RepositoryProvider.of<MemberRepo>(context),
        RepositoryProvider.of<WeatherRepo>(context),
      )..add( LoadDataEvent()),
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [

                    buildAppbar(state),
                    //test
                    buildBody(context,state),
                  ],
                ),
              ),
            ),
            bottomNavigationBar: buildBottom(context),
          );
        }
      ),
    );
  }

   buildBottom(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height * 0.11,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            bottom: 0,
            child: Container(
              height: size.height * 0.11,
              color: Color(0xffe4e6e9),
              width: MediaQuery.of(context).size.width,
              child: CustomPaint(
                painter: BNBCustomPainter(),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(onPressed: (){}, icon: Icon(Icons.home_outlined,color: Colors.white,size: 26,)),
                      IconButton(onPressed: (){}, icon: Icon(Icons.person,color: Colors.white,size: 26,)),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: -size.height * 0.03,
            right: 0,
            left: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: (){
                    print("taped");
                  },
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Colors.white30,
                          Colors.grey.shade400,
                          Colors.white30,
                        ]
                      ),
                      color: Color(0xffdfe1e4),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.shade300,
                            blurRadius: 1,
                            offset: Offset(0,0),
                            spreadRadius: 1
                        )
                      ],
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Container(
                      height: size.height * 0.07,
                      width: size.height * 0.07,
                      decoration: BoxDecoration(
                        color: Color(0xffeaebf3),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.white,
                            blurRadius: 1,
                            offset: Offset(0,0),
                            spreadRadius: 1
                          )
                        ],
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: ShaderMask(
                        shaderCallback: (Rect bounds){
                          return LinearGradient(
                           begin: Alignment.topCenter,
                            end: Alignment.bottomRight,
                            colors: <Color>[
                              Colors.purple,
                              Colors.redAccent,
                            ],
                            tileMode: TileMode.mirror,
                          ).createShader(bounds);
                        },
                          child: Icon(Icons.mic_none_outlined,color: Colors.white,size: size.height * 0.04,)),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 20,
            right: 60,
            left: 0,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.pinkAccent,
                    spreadRadius: 10,
                    offset: Offset(0,0),
                    blurRadius: 20
                  )
                ]
              ),
            ),
          )
        ],
      ),
    );
   }

  buildBody(BuildContext context, HomeState state) {

    return Column(
      children: [
        GestureDetector(
          onTap: () async{
        Navigator.push(context, MaterialPageRoute(builder: (_) => BlocProvider.value(
             value: BlocProvider.of<HomeBloc>(context),
             child: const CurrentLocationScreen(),
           )));

          },
          child: Container(
            height: MediaQuery.of(context).size.height * 0.2,
            margin: EdgeInsets.all(20),
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      Colors.deepPurpleAccent,
                      Colors.pink,
                    ]
                )
            ),
            child: Stack(
              children: [
                if(state is HomeLoadingState)
                  const Center(child: CircularProgressIndicator()),

                if(state is HomeLoadedState)
                  Column(
                  children: [
                    Expanded(child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            BigText(text: "My Location",textColor: Colors.white),
                            SmallText(text: state.myLocation!),
                          ],
                        ),
                        BigText(text: "${kelvinToCelsius(state.currentModel!.temp!).toStringAsFixed(0)}°",textColor: Colors.white,fontSize: 50,),
                      ],
                    )),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.network(state.currentModel!.weather![0].icon!,height: MediaQuery.of(context).size.height * 0.04),
                        SizedBox(width: 5,),
                        SmallText(text: state.currentModel!.weather![0].description!,),
                        Spacer(),
                        SmallText(text: "Độ ẩm ${state.currentModel!.humidity!}%",),

                      ],
                    )
                  ],
                ),


              ],
            ),
          ),
        ),
        AnimatedToggle(
          values: ['Room', 'Devices'],
          onToggleCallback: (value) {

          },
          buttonColor: const Color(0xFF0A3157),
          backgroundColor: const Color(0xFFB5C1CC),
          textColor: const Color(0xFFFFFFFF),
          sizeHeightContext: MediaQuery.of(context).size.height * 0.7,
        ),
        Column(
          children: [
            if(state is HomeLoadingState)
              CircularProgressIndicator(),
            if(state is HomeLoadedState)
              GridView.builder(
                  padding: EdgeInsets.all(20),
                  itemCount: state.listHomeRoom!.length,
                  primary: false,
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                    mainAxisExtent: 280,
                    crossAxisCount: 2,
                  ), itemBuilder: (context, index){
                return GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => DetailScreen()));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.shade400,
                              offset: Offset(0,0),
                              spreadRadius: 1,
                              blurRadius: 20
                          )
                        ]
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                        ),
                        child: Column(
                          children: [
                            Expanded(
                                flex: 1,
                                child: Stack(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: AssetImage(state.listHomeRoom![index].image!),
                                              fit: BoxFit.cover
                                          )
                                      ),
                                    ),
                                    Positioned(
                                      top: 0,
                                      right: 0,
                                      child: Container(
                                        margin: EdgeInsets.all(10),
                                        padding: EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(20),
                                          color: Colors.grey.shade400.withOpacity(0.3),
                                        ),
                                        child: Icon(Icons.more_vert_outlined,color: Colors.white,),
                                      ),
                                    )
                                  ],
                                )),
                            Expanded(
                              flex: 1,
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    BigText(text: state.listHomeRoom![index].name!,textColor: Colors.grey,fontSize: 18,),
                                    SmallText(text: "Device ${state.listHomeRoom![index].device!.length}"),
                                    Spacer(),
                                    SwichAndText(isCheck: state.listHomeRoom![index].device![0].status == "1"?true:false),

                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }),
          ],
        ),



      ],
    );
  }

   buildAppbar(HomeState state) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
      child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      BigText(text: "Home",),
                      GestureDetector(
                        onTap: () async {
                          WeatherRepo homeRoomRepo = WeatherRepo();
                           await homeRoomRepo.getWeather("10.835886", "106.661597");
                        },
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Colors.white24,
                                Colors.white,
                                Colors.white,

                              ],

                            ),
                            boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.6),
                                  offset: Offset(5,3),
                                  blurRadius: 7
                                )
                            ]
                          ),
                          child: Icon(Icons.settings,color: Colors.grey,),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SmallText(text: "Family Members",fontWeight: FontWeight.bold),
                      if(state is HomeLoadingState)
                        CircularProgressIndicator(),
                      if(state is HomeLoadedState)
                        Stack(
                          clipBehavior: Clip.none,
                          children: List.generate(state.listMember!.length, (index) => index==0?CircleAvatar(
                            maxRadius: 20,
                            backgroundImage: AssetImage(state.listMember![index].image!),
                          ):Positioned(
                            right: 30.0*index as double,
                            child: CircleAvatar(
                              maxRadius: 20,
                              backgroundImage: AssetImage(state.listMember![index].image!),
                            ),
                          )
                          ),
                        ),
                    ],
                  ),
                ],
              ),
    );
  }

  double kelvinToCelsius(double kelvin) => kelvin - 273.15;
}

class BNBCustomPainter extends CustomPainter{
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = const Color(0xff5e6271)..style = PaintingStyle.fill;
    Path path = Path()..moveTo(0, 0);

    path.quadraticBezierTo(0, 0, size.width*0.10, 0);
    path.quadraticBezierTo(size.width*0.20, 0, size.width*0.25, size.height/2);
    path.quadraticBezierTo(size.width*0.30, size.height, size.width*0.40, size.height);

    path.quadraticBezierTo(size.width*0.35, size.height, size.width*0.60, size.height);


    path.quadraticBezierTo(size.width*0.7, size.height, size.width*0.75, size.height/2);
    path.quadraticBezierTo(size.width*0.80, 0, size.width*0.90, 0);
    path.quadraticBezierTo(size.width, 0, size.width, 0);

    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    canvas.drawShadow(path, Colors.black, 5, true);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return false;
  }


}