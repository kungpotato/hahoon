import 'dart:async';

import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'appTheme.dart';
import 'modules/login/loginScreen.dart';
import 'modules/login/signUpScreen.dart';

class IntroductionScreen extends StatefulWidget {
  @override
  _IntroductionScreenState createState() => _IntroductionScreenState();
}

class _IntroductionScreenState extends State<IntroductionScreen> {
  var pageController = PageController(initialPage: 0);
  List<PageViewData> pageViewModelData = [];

  Timer? sliderTimer;
  var currentShowIndex = 0;

  @override
  void initState() {
    pageViewModelData.add(PageViewData(
      titleText: '1. ประเมินการเติบโดของรายได้ปีข้างหน้า',
      subText: 'ฟังจากผู้บริหารหรือบทวิเคราะห์',
      assetsImage: 'assets/images/slide1.png',
    ));

    pageViewModelData.add(PageViewData(
      titleText: '2. หามูลค่าปัจจุบัน',
      subText: 'นำตัวเลขงบการเงินมาหามูลค่าที่เหมาะสม',
      assetsImage: 'assets/images/slide2.png',
    ));

    pageViewModelData.add(PageViewData(
      titleText: '3. คำนวน up size',
      subText: 'นำ up size ที่ได้ มาประกอบการตัดสินใจซื้อหุ้น',
      assetsImage: 'assets/images/slide3.png',
    ));

    sliderTimer = Timer.periodic(Duration(seconds: 5), (timer) {
      if (currentShowIndex == 0) {
        pageController.animateTo(MediaQuery.of(context).size.width,
            duration: Duration(seconds: 1), curve: Curves.fastOutSlowIn);
      } else if (currentShowIndex == 1) {
        pageController.animateTo(MediaQuery.of(context).size.width * 2,
            duration: Duration(seconds: 1), curve: Curves.fastOutSlowIn);
      } else if (currentShowIndex == 2) {
        pageController.animateTo(0,
            duration: Duration(seconds: 1), curve: Curves.fastOutSlowIn);
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    sliderTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: AppTheme.getTheme().backgroundColor,
        body: Column(
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).padding.top,
            ),
            Expanded(
              child: PageView(
                controller: pageController,
                pageSnapping: true,
                onPageChanged: (index) {
                  currentShowIndex = index;
                },
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  PagePopup(imageData: pageViewModelData[0]),
                  PagePopup(imageData: pageViewModelData[1]),
                  PagePopup(imageData: pageViewModelData[2]),
                ],
              ),
            ),
            SmoothPageIndicator(
              controller: pageController,
              effect: SlideEffect(
                  dotColor: AppTheme.getTheme().dividerColor,
                  spacing: 5,
                  radius: 8.0,
                  activeDotColor: AppTheme.getTheme().primaryColor),
              count: 3,
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 48, right: 48, bottom: 8, top: 32),
              child: Container(
                height: 48,
                decoration: BoxDecoration(
                  color: AppTheme.getTheme().primaryColor,
                  borderRadius: BorderRadius.all(Radius.circular(24.0)),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: AppTheme.getTheme().dividerColor,
                      blurRadius: 8,
                      offset: Offset(4, 4),
                    ),
                  ],
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.all(Radius.circular(24.0)),
                    highlightColor: Colors.transparent,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                      );
                    },
                    child: Center(
                      child: Text(
                        "เข้าสู่ระบบ",
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 48, right: 48, bottom: 32, top: 8),
              child: Container(
                height: 48,
                decoration: BoxDecoration(
                  color: AppTheme.getTheme().backgroundColor,
                  borderRadius: BorderRadius.all(Radius.circular(24.0)),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: AppTheme.getTheme().dividerColor,
                      blurRadius: 8,
                      offset: Offset(4, 4),
                    ),
                  ],
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.all(Radius.circular(24.0)),
                    highlightColor: Colors.transparent,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignUpScreen()),
                      );
                    },
                    child: Center(
                      child: Text(
                        "สร้างบัญชีใหม่",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 16),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).padding.bottom,
            )
          ],
        ),
      ),
    );
  }
}

class PagePopup extends StatelessWidget {
  final PageViewData? imageData;

  const PagePopup({Key? key, this.imageData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          flex: 8,
          child: Center(
            child: Container(
              width: MediaQuery.of(context).size.width - 120,
              child: AspectRatio(
                aspectRatio: 1,
                child: Image.asset(
                  imageData!.assetsImage!,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(
            child: Text(
              imageData!.titleText!,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(
            child: Text(
              imageData!.subText!,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppTheme.getTheme().disabledColor,
              ),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: SizedBox(),
        ),
      ],
    );
  }
}

class PageViewData {
  final String? titleText;
  final String? subText;
  final String? assetsImage;

  PageViewData({this.titleText, this.subText, this.assetsImage});
}
