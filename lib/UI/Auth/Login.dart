import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:recorder/Controllers/LoginController.dart';
import 'package:recorder/Style.dart';
import 'package:recorder/UI/widgets/Background.dart';
import 'package:recorder/UI/widgets/ButtonOrange.dart';
import 'package:recorder/UI/widgets/DefaultTitle.dart';
import 'package:recorder/Utils/Svg/IconSVG.dart';
import 'package:recorder/Utils/app_keys.dart';
import 'package:recorder/generated/l10n.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  LoginController controller;
  String phoneHint = "+7 (900) 000-00-00";
  String codeHint = "Код";

  @override
  void initState() {
    super.initState();
    controller = LoginController();

    controller.phoneFocusNode.addListener(() {
      if (controller.phoneFocusNode.hasFocus)
        phoneHint = "";
      else
        phoneHint = "+7 (900) 000-00-00";
      setState(() {});
    });
    controller.codeFocusNode.addListener(() {
      if (controller.codeFocusNode.hasFocus)
        codeHint = "";
      else
        codeHint = "Код";
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: Theme.of(context).backgroundColor,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          key: AppKeys.scaffoldKeyAuth,
          body: SingleChildScrollView(
            child: Background(
              title: DefaultTitle(),
              body: body(),
            ),
          ),
        ),
      ),
    );
  }

  Widget body() {
    return PageView(
      physics: BouncingScrollPhysics(),
      // allowImplicitScrolling: true,
      controller: controller.controllerPages,
      children: [stepOne(), stepTwo(), stepThree(), stepFour()],
    );
  }

  Widget stepOne() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            Text(
              S.current.hello_new1,
              style: TextStyle(
                color: cBlack,
                fontWeight: FontWeight.w400,
                fontFamily: fontFamily,
                fontSize: 24,
              ),
            ),
            SizedBox(
              height: 12,
            ),
            Text(
              S.current.hello_new2,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: cBlack,
                fontWeight: FontWeight.w400,
                fontFamily: fontFamily,
                fontSize: 16,
              ),
            ),
            SizedBox(
              height: 24,
            ),
          ],
        ),
        ButtonOrange(
          onTap: () {
            controller.stepOneTap();
          },
          text: S.current.btn_next,
        ),
        SizedBox(),
        SizedBox(),
      ],
    );
  }

  Widget stepTwo() {
    return Padding(
      padding: const EdgeInsets.only(left: 12.0, right: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Text(
                S.current.enter_num,
                style: TextStyle(
                  color: cBlack,
                  fontWeight: FontWeight.w400,
                  fontFamily: fontFamily,
                  fontSize: 14,
                ),
              ),
              SizedBox(
                height: 12,
              ),
              Container(
                width: MediaQuery.of(context).size.width - 70,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: cBackground,
                    borderRadius: BorderRadius.all(Radius.circular(41)),
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(0, 4),
                        blurRadius: 11,
                        spreadRadius: 0,
                        color: Color.fromRGBO(0, 0, 0, 0.17),
                      )
                    ]),
                child: Container(
                  width: MediaQuery.of(context).size.width / 1.6,
                  child: TextField(
                    textAlign: TextAlign.center,
                    controller: controller.controllerNum,
                    inputFormatters: [controller.maskFormatter],
                    keyboardType: TextInputType.number,
                    focusNode: controller.phoneFocusNode,
                    style: TextStyle(
                      color: cBlack,
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                    ),
                    decoration: InputDecoration(
                      alignLabelWithHint: false,
                      border: InputBorder.none,
                      // prefix: Text('+7 '),
                      filled: true,
                      hintText: phoneHint,
                      hintStyle: TextStyle(
                        color: Colors.black45,
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.normal,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Column(
            children: [
              ButtonOrange(
                  onTap: () {
                    controller.stepTwoTap(context);
                  },
                  text: S.current.btn_next),
              SizedBox(
                height: 24,
              ),
              InkWell(
                onTap: () {
                  controller.futureAuthSet(true, restartContext: context);
                },
                child: Text(
                  S.current.later,
                  style: TextStyle(
                    color: cBlack,
                    fontSize: 24,
                    fontFamily: fontFamily,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
          Container(
            decoration: BoxDecoration(
                color: cBackground,
                borderRadius: BorderRadius.all(Radius.circular(15)),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 4),
                    blurRadius: 7,
                    spreadRadius: 0,
                    color: Color.fromRGBO(0, 0, 0, 0.11),
                  )
                ]),
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: Text(
                S.current.desc_register,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: cBlack,
                  fontWeight: FontWeight.w400,
                  fontFamily: fontFamily,
                  fontSize: 14,
                ),
              ),
            ),
          ),
          SizedBox()
        ],
      ),
    );
  }

  Widget stepThree() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Text(
                S.current.enter_code,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: cBlack,
                    fontWeight: FontWeight.w400,
                    fontFamily: fontFamily,
                    fontSize: 14),
              ),
              SizedBox(
                height: 12,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Container(
                  decoration: BoxDecoration(
                      color: cBackground,
                      borderRadius: BorderRadius.all(Radius.circular(41)),
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(0, 4),
                          blurRadius: 11,
                          spreadRadius: 0,
                          color: Color.fromRGBO(0, 0, 0, 0.17),
                        )
                      ]),
                  child: TextField(
                    textAlign: TextAlign.center,
                    focusNode: controller.codeFocusNode,
                    controller: controller.controllerCode,
                    inputFormatters: [controller.maskFormatterCode],
                    keyboardType: TextInputType.number,
                    style: TextStyle(
                      color: cBlack,
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                    ),
                    decoration: InputDecoration(
                      alignLabelWithHint: false,
                      border: InputBorder.none,
                      // prefix: Text('+7 '),
                      filled: true,
                      hintText: codeHint,
                      hintStyle: TextStyle(
                        color: Colors.black45,
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.normal,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Column(
            children: [
              ButtonOrange(
                  onTap: () {
                    controller.stepThreeTap(context);
                  },
                  text: S.current.btn_next),
              Text(
                "",
                style: TextStyle(
                    color: cBlack,
                    fontSize: 24,
                    fontFamily: fontFamily,
                    fontWeight: FontWeight.w400),
              ),
            ],
          ),
          Container(
            decoration: BoxDecoration(
                color: cBackground,
                borderRadius: BorderRadius.all(Radius.circular(15)),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 4),
                    blurRadius: 7,
                    spreadRadius: 0,
                    color: Color.fromRGBO(0, 0, 0, 0.11),
                  )
                ]),
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: Text(
                S.current.desc_register,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: cBlack,
                    fontWeight: FontWeight.w400,
                    fontFamily: fontFamily,
                    fontSize: 14),
              ),
            ),
          ),
          SizedBox()
        ],
      ),
    );
  }

  Widget stepFour() {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
              color: cBackground,
              borderRadius: BorderRadius.all(Radius.circular(15)),
              boxShadow: [
                BoxShadow(
                  offset: Offset(0, 4),
                  blurRadius: 7,
                  spreadRadius: 0,
                  color: Color.fromRGBO(0, 0, 0, 0.11),
                )
              ]),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 25),
            child: Text(
              S.current.hello_old,
              style: TextStyle(
                  color: cBlack,
                  fontSize: 24,
                  fontFamily: fontFamily,
                  fontWeight: FontWeight.w400),
            ),
          ),
        ),
        SizedBox(
          height: 70,
        ),
        iconSvg(IconsSvg.heart, width: 45, color: cOrange),
      ],
    );
  }

  Widget buttonNext({Function onTap}) {
    return GestureDetector(
      onTap: () {
        onTap() ?? null;
      },
      child: Container(
        decoration: BoxDecoration(
            color: cOrange,
            borderRadius: BorderRadius.all(Radius.circular(51))),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 75, vertical: 16),
          child: Text(
            S.current.btn_next,
            style: TextStyle(
              color: cBackground,
              fontSize: 18,
              fontFamily: fontFamily,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }
}
