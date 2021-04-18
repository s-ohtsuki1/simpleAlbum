import 'package:favorite/components/default_button.dart';
import 'package:favorite/constants.dart';
import 'package:favorite/screen/sign_in/sign_in_screen.dart';
import 'package:favorite/screen/splash/components/splash_content.dart';
import 'package:favorite/size_config.dart';
import 'package:flutter/material.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  int currentPage = 0;
  List<Map<String, String>> splashData = [
    {
      "image": "assets/images/splash_camera.png",
      "text": "ようこそ！ Simple Alubumへ！",
    },
    {
      "image": "assets/images/splash_album.png",
      "text": "あなたの思い出に一言コメントを付けて \nアルバムにできます。",
    },
    {
      "image": "assets/images/splash_share.png",
      "text": "アルバムを家族や友達とシェアできます。",
    },
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(20),
          ),
          child: Column(
            children: [
              SizedBox(height: getProportionateScreenHeight(40)),
              Text(
                "Simple Album",
                style: TextStyle(
                  fontSize: getProportionateScreenWidth(36),
                  color: Colors.brown,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Expanded(
                flex: 3,
                child: PageView.builder(
                  onPageChanged: (value) {
                    setState(
                      () {
                        currentPage = value;
                      },
                    );
                  },
                  itemCount: splashData.length,
                  itemBuilder: (context, index) => SplashContent(
                    image: splashData[index]["image"]!,
                    text: splashData[index]["text"]!,
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    // Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        splashData.length,
                        (index) => buildDot(index: index),
                      ),
                    ),
                    Spacer(),
                    DefaultButton(
                      text: "Continue",
                      press: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SignInScreen(),
                          ),
                        );
                      },
                    ),
                    Spacer(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  AnimatedContainer buildDot({int? index}) {
    return AnimatedContainer(
      duration: kAnimationDuration,
      margin: EdgeInsets.only(right: 5),
      height: 6,
      width: currentPage == index ? 20 : 6,
      decoration: BoxDecoration(
        color: currentPage == index ? kPrimaryColor : Color(0xFFD8D8D8),
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}
